Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B6B96B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2019 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393769AbfITRle (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Sep 2019 13:41:34 -0400
Received: from mail-eopbgr770093.outbound.protection.outlook.com ([40.107.77.93]:57353
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393075AbfITRld (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Sep 2019 13:41:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdOMakbVBf9t3Op/d6slJRpGk5nQLCBQPEQKmGe08VUpw8iFN+o8nrwxzRFMoF9aD8UsvyU31mp38kOqD9BdwNh+y60yMipFpGD8ZT/JyuNhI+hoFmNw/mJpoxPOmv8SgCGKcc8R5LBnCN5K7YezbntiQCjla9PnKlu2ltl6Mix0Jf5W03zmrCMbrri5h99RRRNjQKvNmVZo4IQyZicu2NSzgDLlBDOkS8cM8Rz7dDO4D+hhx1F2XzYSNc/zXWUSNRUe8951YBQTWZvkkjlWhxDWJ+0xiNWqHeLHk3kqdDWwjr8djwPTd9W0oPz/bDGNnipEKbhQf8SJ8dmuwD6xlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7LUyejanIOkMQVLuqod5ZLKbqxE5cM0qXi34qwgI2E=;
 b=kQjOg64WKCkbT3yrl+0zc56sjitO1u/wHMysqgSw1qpDu+ZJ6+iQnO59g0AA1MveUCSk75iM0kCZwgFGBaOBLxg6UrPOLflXHzUtJvrl08VFC92NY1QMf7wqGGAqUIl531JtJoWtyfZnDK0GJGTaz+UmQsA/mz5RfT2jH18QvEgeg0rqFio/OHxt4yLKg9vMlKg8cdOaWcHefmrm6eLQeYLpo0Z5LDa77HZNN9wGQUfhw2yQqiBWpxmxlxfGzDjNkjbNM40eYfNRxMhxcp7XbTDVCI0LtKEAlUqz+ZCLuuv85DnMrZL9VeMzwR25r1w+9m8wr2oELUOtpzM0HlSHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7LUyejanIOkMQVLuqod5ZLKbqxE5cM0qXi34qwgI2E=;
 b=czzPyfFdzEmrZ7Arpm/ZBCnjoc1TngRR+bw1YO32t1KuuZbzwlIXVDd24AegzqzOKsa27ASR1phcDVKkBolSkNWBkjtDbqG8SNzXlOF3Ph5WjHH6mX8RVe8/DRs5U46AMJ2hm7EM9guj8dfYkukKn5v84XF5f/axsuXIyYdOkDw=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0170.namprd21.prod.outlook.com (10.173.173.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.11; Fri, 20 Sep 2019 17:41:31 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028%9]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 17:41:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM_SLEEP
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM_SLEEP
Thread-Index: AQHVbzOn66tbgs3I5Ui535QUQicqZKc01dcg
Date:   Fri, 20 Sep 2019 17:41:31 +0000
Message-ID: <DM5PR21MB0137310964E95FD225972004D7880@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1568929540-116670-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568929540-116670-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-20T17:41:29.5424579Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=989008a8-a01e-4c30-b394-67021501df0f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec79b602-1d21-4238-a454-08d73df1c5f3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0170:|DM5PR21MB0170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB01700E494BFCD62AB3C3ABD4D7880@DM5PR21MB0170.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(8676002)(10290500003)(99286004)(81166006)(102836004)(5660300002)(256004)(478600001)(81156014)(26005)(14444005)(8990500004)(6436002)(2501003)(52536014)(66066001)(25786009)(10090500001)(8936002)(71200400001)(71190400001)(305945005)(2201001)(186003)(66476007)(6246003)(66946007)(486006)(86362001)(3846002)(229853002)(74316002)(64756008)(66446008)(14454004)(476003)(66556008)(9686003)(7736002)(76116006)(6506007)(446003)(6116002)(1511001)(110136005)(76176011)(11346002)(33656002)(316002)(55016002)(22452003)(7696005)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0170;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZ9SybVA9GzsCGvB/S8A4c2i5BGKOQQIFFxVPSiXoUetgZU72CoFnDRae/dp+/Lg4tVZcwnALm+pRGKGJxCpEjPzVqhuJ6nEtgra9zl8i01vmz0o8HszF61CRCiRawR8GeuFBzvvF+j0i9n96a9AM4Us5hlogGlPqI9/XCDyqlEonpoFTQkVft1GhpT7e3XPxgw1C+17H7RJKeHbCR8Q4p2WZsSeDYlftpyVDMgO9rFm7hj16eGTyDulMCrsqdK89MG6pYobwVUEAGPZ1yKvhGo/nlfu7sFxKoYIDSQwvQSHxAkK4mEE2tSnrXmWEmLIStrSHjDvGg6lbSqgyPVpQt9McUAtkm9zy1+OQVVxgKTrjIervSw+sDC6lFanihpKr3jQlWxLUVt7fuS1U8W8jx+R+AvOrZS71cuiaeHL0DE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec79b602-1d21-4238-a454-08d73df1c5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 17:41:31.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSEibdmRfgl1E3uHiaOF0i7jU1UKGNQYpddmMPM0lItbajSFXisqP5lWXATUwRPGmamkh6YPgO3kbIwZtEDtuAeqC6RWBv3t3VdXsyAqlIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0170
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNkYXksIFNl
cHRlbWJlciAxOSwgMjAxOSAyOjQ2IFBNDQo+IA0KPiBJZiBDT05GSUdfUE1fU0xFRVAgaXMgbm90
IHNldCwgd2UgY2FuIGNvbW1lbnQgb3V0IHRoZXNlIGZ1bmN0aW9ucyB0byBhdm9pZA0KPiB0aGUg
YmVsb3cgd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjIyMDg6MTI6IHdh
cm5pbmc6IOKAmHZtYnVzX2J1c19yZXN1bWXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy0NCj4g
V3VudXNlZC1mdW5jdGlvbl0NCj4gZHJpdmVycy9odi92bWJ1c19kcnYuYzoyMTI4OjEyOiB3YXJu
aW5nOiDigJh2bWJ1c19idXNfc3VzcGVuZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLQ0KPiBX
dW51c2VkLWZ1bmN0aW9uXQ0KPiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjkzNzoxMjogd2Fybmlu
Zzog4oCYdm1idXNfcmVzdW1l4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstDQo+IFd1bnVzZWQt
ZnVuY3Rpb25dDQo+IGRyaXZlcnMvaHYvdm1idXNfZHJ2LmM6OTE4OjEyOiB3YXJuaW5nOiDigJh2
bWJ1c19zdXNwZW5k4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstDQo+IFd1bnVzZWQtZnVuY3Rp
b25dDQo+IA0KPiBGaXhlczogMjcxYjIyMjRkNDJmICgiRHJpdmVyczogaHY6IHZtYnVzOiBJbXBs
ZW1lbnQgc3VzcGVuZC9yZXN1bWUgZm9yIFZTQyBkcml2ZXJzIGZvcg0KPiBoaWJlcm5hdGlvbiIp
DQo+IEZpeGVzOiBmNTMzMzVlMzI4OWYgKCJEcml2ZXJzOiBodjogdm1idXM6IFN1c3BlbmQvcmVz
dW1lIHRoZSB2bWJ1cyBpdHNlbGYgZm9yDQo+IGhpYmVybmF0aW9uIikNCj4gUmVwb3J0ZWQtYnk6
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IERleHVhbiBD
dWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiANCj4gSW4gdjI6DQo+IAl0ZXN0IENP
TkZJR19QTV9TTEVFUCByYXRoZXIgdGhhbiBDT05GSUdfUE0uIFRoYW5rcywgQXJuZCENCj4gDQo+
ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykNCj4gDQoNClJldmlld2VkLWJ5OiAgTWljaGFlbCBLZWxsZXkgPG1pa2Vs
bGV5QG1pY3Jvc29mdC5jb20+DQo=
