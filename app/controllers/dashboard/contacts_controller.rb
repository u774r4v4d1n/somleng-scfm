module Dashboard
  class ContactsController < Dashboard::BaseController
    include ValidateSchemaController
    self.request_schema = ContactRequestSchema

    private

    def association_chain
      current_account.contacts
    end

    def permitted_params
      params.require(:contact).permit(:msisdn, METADATA_FIELDS_ATTRIBUTES).to_h
    end

    def before_update_attributes
      clear_metadata
    end

    def build_key_value_fields
      build_metadata_field
    end
  end
end
