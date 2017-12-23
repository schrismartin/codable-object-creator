//: Playground - noun: a place where people can play

import UIKit

let jsonString = """
{
  "issue_types": [
    {
      "type_code": "BARE",
      "type_description": "Bare Areas"
    },
    {
      "type_code": "WEEDS",
      "type_description": "AREAS WITH WEEDS"
    },
    {
      "type_code": "COLRVAR",
      "type_description": "VISIBLE COLOR VARIATIONS"
    },
    {
      "type_code": "BROWN",
      "type_description": "LAWN IS BROWN"
    },
    {
      "type_code": "BILLING",
      "type_description": "BILLING DISCREPANCY"
    }
  ],
  "reschedule_dates": [
    {
      "reschd_appt_date": "20171115",
      "reschd_appt_seq": "1",
      "reschd_appt_type": "RESCH"
    },
    {
      "reschd_appt_date": "20171120",
      "reschd_appt_seq": "2",
      "reschd_appt_type": "RESCH"
    },
    {
      "reschd_appt_date": "20171121",
      "reschd_appt_seq": "3",
      "reschd_appt_type": "RESCH"
    },
    {
      "reschd_appt_date": "20171122",
      "reschd_appt_seq": "4",
      "reschd_appt_type": "RESCH"
    }
  ],
  "resolution_types": [
    {
      "resolution_desc": "Provide information for your next svc visit",
      "resolution_seq": "00001",
      "resolution_type_code": "INFO"
    },
    {
      "resolution_desc": "REQUEST CALL FROM TRUGREEN",
      "resolution_seq": "00002",
      "resolution_type_code": "CALL"
    },
    {
      "resolution_desc": "EXPEDITE YOUR NEXT SERVICE VISIT",
      "resolution_seq": "00003",
      "resolution_type_code": "RESCH"
    },
    {
      "resolution_desc": "SCHEDULE ADDITIONAL FREE SERVICE VISIT",
      "resolution_seq": "00004",
      "resolution_type_code": "RESVC"
    }
  ],
  "reservice_dates": [
    {
      "resvc_appt_date": "20171109",
      "resvc_appt_seq": "1",
      "resvc_appt_type": "RESVC"
    },
    {
      "resvc_appt_date": "20171113",
      "resvc_appt_seq": "2",
      "resvc_appt_type": "RESVC"
    },
    {
      "resvc_appt_date": "20171114",
      "resvc_appt_seq": "3",
      "resvc_appt_type": "RESVC"
    },
    {
      "resvc_appt_date": "20171115",
      "resvc_appt_seq": "4",
      "resvc_appt_type": "RESVC"
    }
  ],
  "reschedule_begin_date": "20171106",
  "reschedule_end_date": "20171226",
  "reservice_begin_date": "20171106",
  "reservice_end_date": "20171130",
  "service_message_1": "It takes about 2 weeks for the full effects of the application to be visible, and over treating the property may have negative effects.  If you need urgent assistance, please contact TruGreen at 1-800-Trugreen for our customer service department.",
  "service_message_2": null
}
"""

if let creator = try? ObjectCreator(jsonString: jsonString, topLevelObjectName: "ReportProblemInfo") {
    print(creator.export())
}
