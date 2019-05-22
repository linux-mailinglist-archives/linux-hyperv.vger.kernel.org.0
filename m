Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FDB25C02
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 May 2019 05:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfEVDOY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 May 2019 23:14:24 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:9964
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbfEVDOY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 May 2019 23:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=b8xz1sSW894/X93HrONUhDQ0m5F2OWJjhQgjKV6NtEys7+LH9GzIPcTYh69E9rNNpYjFYXgy0q2GVavIAP+/1fIJrpbYVQlp5eOmjkcaDZkxPEWeLODmlgor+usFb4/W8X1tzn+S3Xo86IdpchmD70w+Tc9lOxRQcfoCYR7MNAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nVHBDJ0o6EZ3T33XVej5ur+t3VJTljWJYfKN1Q19Do=;
 b=mOo6IpW+GP4+mLSAJtNq1hjBXtbTfMjZW9vJp5ncAYhihOmvfzAYjlfGoHHvOqyNF+BHJEW+27OTT57JboAiFmtyLLd8c2XaXKAKEYTeBCP+lj08qu4pabouvWefEy0928q1IYumEuxrFFlHX/dZs61qfNacsEUvZTGqeXNq9Yg=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nVHBDJ0o6EZ3T33XVej5ur+t3VJTljWJYfKN1Q19Do=;
 b=lYiLT9caHTD7OeHYXcdBo7Cnm1/00fHr2j8zvA/3Sq8cNDN5vXw/0PI7uix7Kf/iviDskFny4I424a9tPk9VmRbgj2lncwJApn0iYt/uz8fzmqUo3iscthaoErkFd8/6Ojfh7AXWa9iYf5LiSIPz6JohW60mz8WmHULJ8l/tp2g=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.6; Wed, 22 May 2019 03:14:15 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%3]) with mapi id 15.20.1943.007; Wed, 22 May 2019
 03:14:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVDpIz+mZnowKmCU+oYiS1gYdC2KZ2e2rg
Date:   Wed, 22 May 2019 03:14:15 +0000
Message-ID: <PU1P153MB01690809D82F85EDE4BC5B9CBF000@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-22T03:14:11.1596449Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6b47c18-aa53-4132-83f2-a2329c8dbc98;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:e0e1:6836:3789:8439]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1790d6e-42c3-422f-e8b8-08d6de63922d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0154;
x-ms-traffictypediagnostic: PU1P153MB0154:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01546DB3AEB45D15DEEFE278BF000@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(189003)(478600001)(74316002)(33656002)(10090500001)(22452003)(7696005)(76176011)(316002)(86612001)(102836004)(2501003)(6506007)(99286004)(2201001)(14454004)(86362001)(8990500004)(54906003)(110136005)(10290500003)(1511001)(6436002)(81166006)(76116006)(8676002)(7736002)(81156014)(305945005)(256004)(14444005)(6116002)(9686003)(55016002)(53936002)(25786009)(6246003)(4326008)(2906002)(8936002)(73956011)(66946007)(66446008)(229853002)(66476007)(66556008)(64756008)(71200400001)(71190400001)(11346002)(446003)(486006)(46003)(68736007)(476003)(5660300002)(52536014)(4744005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b0f2EjPMgBrX6bjtaCft6VXEb/pjUOsYHnOD7WkVT0qeWgrYE4G+Nq6IcUWTFHoP1uw+q/Uzaeg+I2S0MW0pBtwsRUldzBXZ4b1TrO3WHjcf+7fFa8ZEUmdvCxzC1lslOpfXKUSJz6ZfRSnT2aDRhv9UfHsyB1Z5LcAPEvE3vjGnLMzbWDJUN+dkxd//NpR2Doe/0R/w9o4rSrFbJ8m+fZOxHk05akjLSvkYbXIKXcd0cxynU3aGkGz3Mh+Ukf0LZeel0h5tAWoHrhxo3SlCIMRjZDwewt6I5rwP9e4jDLp7Yk93Ol+rmz4UrVV4DeAf8rTq6lHEUOvx9mgck3zWzBpRDqlUIHX22/93c5IM/AcvRDt5DQQTFh+KN/+UryuU6cZ3zxJX10H1Dd935zIYJJn7bHEW6ALJKplajum47aM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1790d6e-42c3-422f-e8b8-08d6de63922d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 03:14:15.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IFNlbnQ6IFN1bmRh
eSwgTWF5IDE5LCAyMDE5IDM6MjkgUE0NCj4gDQo+IER1ZSB0byBBenVyZSBob3N0IGFnZW50IHNl
dHRpbmdzLCB0aGUgZGV2aWNlIGluc3RhbmNlIElEJ3MgYnl0ZXMgOCBhbmQgOQ0KPiBhcmUgbm8g
bG9uZ2VyIHVuaXF1ZS4gVGhpcyBjYXVzZXMgc29tZSBvZiB0aGUgUENJIGRldmljZXMgbm90IHNo
b3dpbmcgdXANCj4gaW4gVk1zIHdpdGggbXVsdGlwbGUgcGFzc3Rocm91Z2ggZGV2aWNlcywgc3Vj
aCBhcyBHUFVzLiBTbywgYXMgcmVjb21tZW5kZWQNCj4gYnkgQXp1cmUgaG9zdCB0ZWFtLCB3ZSBu
b3cgdXNlIHRoZSBieXRlcyA0IGFuZCA1IHdoaWNoIHVzdWFsbHkgcHJvdmlkZQ0KPiB1bmlxdWUg
bnVtYmVycy4NCj4gDQo+IEluIHRoZSByYXJlIGNhc2VzIG9mIGNvbGxpc2lvbiwgd2Ugd2lsbCBk
ZXRlY3QgYW5kIGZpbmQgYW5vdGhlciBudW1iZXINCj4gdGhhdCBpcyBub3QgaW4gdXNlLg0KPiBU
aGFua3MgdG8gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IGZvciBwcm9w
b3NpbmcgdGhpcyBpZGVhLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFpeWFuZyBaaGFuZyA8aGFp
eWFuZ3pAbWljcm9zb2Z0LmNvbT4NCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQoNClJl
dmlld2VkLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KDQo=
