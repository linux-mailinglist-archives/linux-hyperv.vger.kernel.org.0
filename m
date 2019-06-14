Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6C46B3C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNUsL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 16:48:11 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com ([40.107.81.120]:25024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfFNUsL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 16:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=KjexmCFett09iHl/ebu6gjdsFNlKezoG9xwCgWD3k7qZi1aYQNbV7D6U3xVdFXiFb1Jq6sVTe7GQHMllzpV56V6sfmEPIbnGNzjY5OOctZrbf/FN7FXUdsPr8rjqCC+IwT9S7vgXUlEvKg9bHcP7FSb3+bnXp02Bf7xcwZdSU4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZiI5ITJOuh0sqoAI6GtR3gCNsvdaW/G7ZqmWKVhEBI=;
 b=ahaD/6XFkZfhkw6GA31wUJexngXKP3Youw2+cXLK/Ll5KYxGojtovU1V6i1jNyBoz2en6MKJPBeLd9s0GOcLtthgZlapeZrHGiThqRHG7Npa1TT8Gx5wwCWjXDDYz4AOHMJjUXkult7T/WFtIPXJ/ShiZ9JK/YWS3vXGPrcweyA=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZiI5ITJOuh0sqoAI6GtR3gCNsvdaW/G7ZqmWKVhEBI=;
 b=kwFqAHP7TVPYiOsWjFSW7MTUc1XEA5V3rxjGsnmDS5xuKOVBZqks010XehyaXTJvYp/DPK0ZcNBLDnSahwowUthRTkeMSgVPm/uqn61OiWHtMWhoCIqdnF6aBi7vmJlhu+1+nJnH9Nzaz+39Dh9YHIo7+Kk+I5wBvRJgPTTIFBA=
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 (2603:10b6:208:92::22) by BL0PR2101MB0980.namprd21.prod.outlook.com
 (2603:10b6:207:36::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.1; Fri, 14 Jun
 2019 20:48:06 +0000
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052]) by BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052%2]) with mapi id 15.20.2008.007; Fri, 14 Jun 2019
 20:48:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Topic: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03qabnRQg
Date:   Fri, 14 Jun 2019 20:48:06 +0000
Message-ID: <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1560536224-35338-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-14T20:48:03.8463956Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e15e098-66cc-41b5-9a88-268aec453091;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97624ad9-ca1d-4975-36ae-08d6f1099a8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0980;
x-ms-traffictypediagnostic: BL0PR2101MB0980:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BL0PR2101MB0980F6D284A8DD54A5458FCDD7EE0@BL0PR2101MB0980.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(11346002)(110136005)(25786009)(486006)(476003)(52536014)(446003)(66556008)(66946007)(10290500003)(76116006)(66446008)(66476007)(86362001)(73956011)(2201001)(64756008)(2501003)(1511001)(316002)(22452003)(4326008)(66066001)(54906003)(68736007)(305945005)(14444005)(256004)(3846002)(53936002)(6436002)(7416002)(6116002)(52396003)(33656002)(14454004)(2906002)(7696005)(7736002)(81156014)(81166006)(76176011)(229853002)(102836004)(10090500001)(5660300002)(6246003)(6506007)(8676002)(71190400001)(8990500004)(9686003)(99286004)(55016002)(71200400001)(8936002)(186003)(74316002)(26005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0980;H:BL0PR2101MB1348.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qI0OaEOA1MrpvyUPLShhhkY0B3v44ljoxgnr/8O9eRJAVOhhZRZzpLS/FDUxUj8SbJYh7nrw9L+APvLfdsWZ6wz+yRX+gqY6IgcpeZqbIakoEz6ySAePzVaJaV3AB9InnI+neSP59h14VEmx48v/zCbtOpTsbmDC7jLA2e2x2O90rP4TLKlwK9M97gJSq6NceuTIrqkqm8Nny9DTBWhaOqNLZbdQCY1Lu/AhIQxk8kbOwi+REFsW2wq65FSb3XXlsjWGu9vveV1MMkkNLQJ1ysGZ9cCIlGrsslVfnPVubWYcKNK0xL2jEtdhf88dH1UcHn1Ed3KeRtod3hXq5fWBTa+hQXWIQ1+9IYoAC5iXvfbEtJUkhy18fCaudpvLpUgCXBaG3EqEfZEbigvoesNUNVKnX64mUct3/8GO2AmMoqQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97624ad9-ca1d-4975-36ae-08d6f1099a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 20:48:06.7396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0980
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gIFNlbnQ6IEZyaWRheSwgSnVu
ZSAxNCwgMjAxOSAxMToxOSBBTQ0KPiANCj4gSW4gYSBMaW51eCBWTSBydW5uaW5nIG9uIEh5cGVy
LVYsIHdoZW4gQUNQSSBTNCBpcyBlbmFibGVkLCB0aGUgYmFsbG9vbg0KPiBkcml2ZXIgKGRyaXZl
cnMvaHYvaHZfYmFsbG9vbi5jKSBuZWVkcyB0byBhc2sgdGhlIGhvc3Qgbm90IHRvIGRvIG1lbW9y
eQ0KPiBob3QtYWRkL3JlbW92ZS4NCj4gDQo+IFNvIGxldCdzIGV4cG9ydCBhY3BpX3NsZWVwX3N0
YXRlX3N1cHBvcnRlZCgpIGZvciB0aGUgaHZfYmFsbG9vbiBkcml2ZXIuDQo+IFRoaXMgbWlnaHQg
YWxzbyBiZSB1c2VmdWwgdG8gdGhlIG90aGVyIGRyaXZlcnMgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9hY3BpL3NsZWVwLmMgICAgfCAzICsrLQ0KPiAgaW5jbHVkZS9hY3BpL2FjcGlf
YnVzLmggfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9zbGVlcC5jIGIvZHJpdmVy
cy9hY3BpL3NsZWVwLmMNCj4gaW5kZXggYTM0ZGVjY2Q3MzE3Li42OTc1NTQxMWUwMDggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9zbGVlcC5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9zbGVl
cC5jDQo+IEBAIC03OSw3ICs3OSw3IEBAIHN0YXRpYyBpbnQgYWNwaV9zbGVlcF9wcmVwYXJlKHUz
MiBhY3BpX3N0YXRlKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBib29sIGFj
cGlfc2xlZXBfc3RhdGVfc3VwcG9ydGVkKHU4IHNsZWVwX3N0YXRlKQ0KPiArYm9vbCBhY3BpX3Ns
ZWVwX3N0YXRlX3N1cHBvcnRlZCh1OCBzbGVlcF9zdGF0ZSkNCj4gIHsNCj4gIAlhY3BpX3N0YXR1
cyBzdGF0dXM7DQo+ICAJdTggdHlwZV9hLCB0eXBlX2I7DQo+IEBAIC04OSw2ICs4OSw3IEBAIHN0
YXRpYyBib29sIGFjcGlfc2xlZXBfc3RhdGVfc3VwcG9ydGVkKHU4IHNsZWVwX3N0YXRlKQ0KPiAg
CQl8fCAoYWNwaV9nYmxfRkFEVC5zbGVlcF9jb250cm9sLmFkZHJlc3MNCj4gIAkJCSYmIGFjcGlf
Z2JsX0ZBRFQuc2xlZXBfc3RhdHVzLmFkZHJlc3MpKTsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xf
R1BMKGFjcGlfc2xlZXBfc3RhdGVfc3VwcG9ydGVkKTsNCj4gDQo+ICAjaWZkZWYgQ09ORklHX0FD
UElfU0xFRVANCj4gIHN0YXRpYyB1MzIgYWNwaV90YXJnZXRfc2xlZXBfc3RhdGUgPSBBQ1BJX1NU
QVRFX1MwOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmggYi9pbmNsdWRl
L2FjcGkvYWNwaV9idXMuaA0KPiBpbmRleCAzMWI2Yzg3ZDYyNDAuLjViMTAyZTdiYmYyNSAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgNCj4gKysrIGIvaW5jbHVkZS9hY3Bp
L2FjcGlfYnVzLmgNCj4gQEAgLTY1MSw2ICs2NTEsOCBAQCBzdGF0aWMgaW5saW5lIGludCBhY3Bp
X3BtX3NldF9icmlkZ2Vfd2FrZXVwKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gYm9vbCBlbmFibGUp
DQo+ICB9DQo+ICAjZW5kaWYNCj4gDQo+ICtib29sIGFjcGlfc2xlZXBfc3RhdGVfc3VwcG9ydGVk
KHU4IHNsZWVwX3N0YXRlKTsNCj4gKw0KPiAgI2lmZGVmIENPTkZJR19BQ1BJX1NMRUVQDQo+ICB1
MzIgYWNwaV90YXJnZXRfc3lzdGVtX3N0YXRlKHZvaWQpOw0KPiAgI2Vsc2UNCj4gLS0NCj4gMi4x
OS4xDQoNCkl0IHNlZW1zIHRoYXQgc2xlZXAuYyBpc24ndCBidWlsdCB3aGVuIG9uIHRoZSBBUk02
NCBhcmNoaXRlY3R1cmUuICBVc2luZw0KYWNwaV9zbGVlcF9zdGF0ZV9zdXBwb3J0ZWQoKSBkaXJl
Y3RseSBpbiBodl9iYWxsb29uLmMgd2lsbCBiZSBwcm9ibGVtYXRpYw0Kc2luY2UgaHZfYmFsbG9v
bi5jIG5lZWRzIHRvIGJlIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCB3aGVuIHRoZQ0KSHlwZXIt
ViBBUk02NCBzdXBwb3J0IGlzIGFkZGVkLiAgSWYgdGhhdCBkb2Vzbid0IGNoYW5nZSwgYSBwZXIt
YXJjaGl0ZWN0dXJlDQp3cmFwcGVyIHdpbGwgYmUgbmVlZGVkIHRvIGdpdmUgaHZfYmFsbG9vbi5j
IHRoZSBjb3JyZWN0IGluZm9ybWF0aW9uLiAgVGhpcw0KbWF5IGFmZmVjdCB3aGV0aGVyIGFjcGlf
c2xlZXBfc3RhdGVfc3VwcG9ydGVkKCkgbmVlZHMgdG8gYmUgZXhwb3J0ZWQgdnMuDQpqdXN0IHJl
bW92aW5nIHRoZSAic3RhdGljIi4gICBJJ20gbm90IHN1cmUgd2hhdCB0aGUgYmVzdCBhcHByb2Fj
aCBpcy4NCg0KTWljaGFlbA0K
