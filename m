Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0B302E3F
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jan 2021 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbhAYVrZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jan 2021 16:47:25 -0500
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:55200
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732228AbhAYVqm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 16:46:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK04KNVitXXaksqdIKQcCnmwvz1se5z+QOGvBV5L9ISCpG4unEa2qxmAiOoOPMa4huO77FZbXjOBtMzo5lfGZ3a2cjQG/bkv+DDrazfkQY1+QXT10nWwXoHHzNNqe9b0+94/0ft0sT6KrTAcGDizlLegeADumnQGNJ1DZaN21w9g/ytgYTS5tFWalHgKqv1JcCWJ69pngfD8m5uVB5aDM5zD1B/3YtdMfd5AkgJSQfXErMT1W7h2sNIqD6P4xrU5QDWS4rqPF7hZTzOjwDB4U5WIo313r8h5DTJ2uNwQV5M5XNq5TeLlfHUWbfolVsu3H7YYMc6Errcl4XqVqC4vOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ihQD3b5jQ2XiVlnW/HrChJjRpMn8h02OjMYZvlmemw=;
 b=kJBomKzFKdcsjZqyPTyIwe12WC/NXhzGjOtCdCcUfIQe/ghEUnCc4ioGj07AIg0sLabDlTuV6tXo+Q0+HXL8IRrIeALSmVqMXsAtQJ9kWbr2ohvlWv94B01zjY29yEtBqDqXEHZJ9fVcHrRqeY7ZSElmsVD4Ev974qqnMZ37ZPtAHInaWQ7jZSI0B0RFpWX7/l1ctxC9kXsESYe2b18vZymXAKVtHaMElQDfZtvxtYrU0FTFHd1fmiFWaIRzYcI7qxlxIatEjb8VKEHhSWDT/0s08beAkpX2oy2CHxsVk0fmzDrbgmeBSK+vxtARy5vPjP9MsEaKG4y/uqkvPY8j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ihQD3b5jQ2XiVlnW/HrChJjRpMn8h02OjMYZvlmemw=;
 b=c7lel+8uEni3iR0BNeQYJW1XJXYrRj1IermJ1PLpf0YU7iK9FgUMQzmaUIWiCF86aMdJ+5po+vbpQMH5fOrKxmI0ZoIzG8XGPO1mdus0pty/dHQRrF1Kt6xaZw2KSRR/MSJD5Tnj3kPoHjQjrJRMw1OdZLFX0d3BOWvMtb/gVSc=
Received: from (2603:10b6:301:7e::39) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Mon, 25 Jan 2021 21:45:47 +0000
Received: from MWHPR2101MB0874.namprd21.prod.outlook.com
 ([fe80::29b9:117c:5928:1a7d]) by MWHPR2101MB0874.namprd21.prod.outlook.com
 ([fe80::29b9:117c:5928:1a7d%4]) with mapi id 15.20.3825.004; Mon, 25 Jan 2021
 21:45:47 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Jon Stanley <jonstanley@gmail.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] hv_balloon issues??
Thread-Topic: [EXTERNAL] hv_balloon issues??
Thread-Index: AQHW81dxNnLX57qPe0Ojx4np0pusjKo40NCggAAEjYCAAAnrAA==
Date:   Mon, 25 Jan 2021 21:45:46 +0000
Message-ID: <MWHPR2101MB08745E0B8713F66FADC3BC73A0BD9@MWHPR2101MB0874.namprd21.prod.outlook.com>
References: <CALY6xngo6fU7NoEgrmP_qtdz4OMQgKo9CiJno2uhtWie0ze3Rw@mail.gmail.com>
 <MWHPR2101MB0874A5A65BD03A5FB7857668A0BD9@MWHPR2101MB0874.namprd21.prod.outlook.com>
 <CALY6xniUous7gsWSb4YrzOrKk138CHqaYfeZCNqG7ki97TH4qQ@mail.gmail.com>
In-Reply-To: <CALY6xniUous7gsWSb4YrzOrKk138CHqaYfeZCNqG7ki97TH4qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32aeb776-0a8f-4220-9370-f17fcd25e394;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-25T21:42:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:f550:48f5:98ae:e461:a13a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 930632a3-f039-4623-d028-08d8c17a9355
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1873F9D9A9EEDB09382D1E7CA0BD9@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bolFZQn+ZPl+bkvILEENFaBsAhxft6YCBEREmIqZ88KS4WUbryDm/1TbXyAltdPrUs7QeHiEGB6V6MMPI9OgtR5IUSLbDziXKPvEetkiN5nUDN2ZAJtlckmIW0XtyjYSL1ha4elbNRx4Mf0tXJ6XrBl9Sp8TfLi/OiIsXZiEKqsG4YaFtfRILthntw2HYEHu718T1hSptcshudYNiob3uca+HU/lAP8ni7S+OToIosoPRqKf2t1BQRFfPyX501ZCJvgXblVqK5EdAtZUM5+xHSGBZeSM+wsCdbMixjPILy6VyZUJ/q102cPvXj8Rgjo5De+rWfrQoC9dfMm7tGgscKPazxfzTUOVkx4U2Ee465us3x+3tq4ORPMLVmxnis6siey7JxrvWInB1366FbpCB4FSQGWE5W3sAL4pagCGR4DgrS/KHbe5XgkyPal9L6mxDPKzGM+yGiLZJWo8sGUEluFIOFKyNvJUro3NCu7bmMcGWTV3bkWYE9Pc70TBUVMQzo2lTjw81YTf/PajKQJBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2101MB0874.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(76116006)(82950400001)(8990500004)(82960400001)(7696005)(9686003)(55016002)(53546011)(186003)(6506007)(83380400001)(54906003)(316002)(478600001)(71200400001)(33656002)(64756008)(2906002)(66556008)(52536014)(10290500003)(66446008)(86362001)(66476007)(6916009)(8676002)(66946007)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WkVwTC8vK2pkR0ttVXhMRXhVUEpLejlpVTdLY0lJcGpJOEJxdVZRd1F3bzg3?=
 =?utf-8?B?ZEVpU21UR3VLZDBpbDdJQkZPcXY0UzIzcHVOV1hpREZvR3owWHhJYzZGWGdw?=
 =?utf-8?B?MjVEQjJ5N1hIK2o4WXF1ejlLaFdiRm9obkNUZlN6N1JjSXlDdXQyTGtETjd6?=
 =?utf-8?B?b2NDQXdpOFlicmtRSjJwOXcwU1Q5SVFoSlNjelpteldoRWcwYll5VXRwZzdS?=
 =?utf-8?B?YlhCeldEaE5nTDV4NHAzUXMrY3hHT3diQnlXZnFHOFZtazJlMno4aTRrcWFm?=
 =?utf-8?B?MXRXc25tUE9rc3JrT1YzckFzYjFLZ3ZFT1FUOUpsdUtzL0drSU9OZDlSV3BL?=
 =?utf-8?B?Y05aWW5GUUlQVEJPWk0reXczaWhOS091NjUrYjZNTjZVelhkN0QvYkhvOGQ5?=
 =?utf-8?B?dlZMVTFYN3RYTy9TdUZoMG55dFdvWWkvSmlqd0xnNTBHYTBKOWsxbktmRERN?=
 =?utf-8?B?TFUvZjNuQWR0TlQ0YmZJcDNHOExyREw0akRPd24zSDh6UC85dlRBNE5pZGpG?=
 =?utf-8?B?ZU5jcFZYbmtwZWhtM0wydDU1bXZmcVh3QStiTEVrd1ZyZnFXaisxMGdpc0Rj?=
 =?utf-8?B?ZElXYkR6THhJMEphTk9HQi9qUFBQN255QmxmQTZFUGFWcjFCaUZscC9FZ0Ft?=
 =?utf-8?B?ekdKMEJ0SUlWb0xhTXNYTThsWFU1TGdsbWVLeTl5eTdvZzNvT2gydHR4NytP?=
 =?utf-8?B?YjdiQ1NWUDhTWTdVZlFmVWpyZWF2Wmx6eGtRRnJrVlJRb0hWckZ4ZVYwNWVY?=
 =?utf-8?B?alkvSjM1dGNzTWhPa0ZaV2tadWFJdVY1bk5VZERjd3RYSTZWNjVaR1I3YnVE?=
 =?utf-8?B?MnlzSUJSREc3NUh1UHpjbFdidlY5bkN1WjhkdUFvbmUxczFCdTV2dURFZDVk?=
 =?utf-8?B?U2c0TzBhTmpjK1ZwcEs2VExNYzJGZ2tzUmM0V1RLTTdkbnZ3ZFgrNnNrT0to?=
 =?utf-8?B?RUphcUE5aEI4OXhMSkVEd1VFZWdQekVJTVU1a29ZWk5zeFE1elRnODdMVjg5?=
 =?utf-8?B?VWRwL0ZXcnpRZ3Fpa1pybGNNVW5HSnB6RW5kL3RaN2hodi9ER05JMkJSdXZy?=
 =?utf-8?B?WWxqMEw0N2c5eFhROW1odk0vN1FNYjRHMnJjZjZsYndrazgzc2pRaWRJampX?=
 =?utf-8?B?SU9VSzdxT0k5M2Mvd3lmWDBneHVCYXg5cldnakxjVldkVFpnc2FEKzAvcERQ?=
 =?utf-8?B?aWpLMlFUQjdYL0ZRalkxNGJna2cwRk1IcnJxSzZQQ1A3N1Q1MXpZaFRKVGdu?=
 =?utf-8?B?S1g3QVJQcHBnZzk0cU9aRTFONHJCSGgxQnBiSW5FWnhqSkdsdUZYNGlPM0l3?=
 =?utf-8?B?dmtobTNiK2V6anRMZjJxLzhMejZpcDJwVU5PZmJRc1E2RTcyTmNpOGlMdDht?=
 =?utf-8?B?Z2pvZ1Y0NkFHRm5oc1VrM1NkTlFIV1RxeDQweFlUVUUrUHFoYTN6QnlUUjVu?=
 =?utf-8?B?bDBxL0JPT1VYZzhHb1hheTdTYWFObkZ1MzBIOTNuL2gyN0RJYjc4NjVzOXdI?=
 =?utf-8?Q?KUnHwf8KfXo9vjNU8FpEpVof9ox?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2101MB0874.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930632a3-f039-4623-d028-08d8c17a9355
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 21:45:47.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyJYFd0sVa7DQG8uaxos5jBjLCh45+XudJHoknY0D6c+3xuvJh1lwcpp9AIYpozj95x2qiZGbAYYolxnAdPYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhlIERNIGZlYXR1cmUgcHJvdmlkZXMgYSBmZWVkYmFjayBsb29wIGZvciBtYW5hZ2luZyB0aGUg
Z3Vlc3QgbWVtb3J5IGR5bmFtaWNhbGx5IGJldHdlZW4gdGhlIG1pbiBtZW1vcnkgYW5kIHRoZSBt
YXggbWVtb3J5LiBJZiB0aGUgbWVtb3J5IHByZXNzdXJlIGlzIGxvdywgdGhlIGhvc3Qgd2lsbCBk
cmFpbiB0aGUgbWVtb3J5IG91dCBvZiB0aGUgZ3Vlc3QgLSB0aGUgZmxvb3Igb24gd2hhdCB3aWxs
IGJlIGxlZnQgaW4gdGhlIGd1ZXN0IGlzIHRoZSBtaW4gbWVtb3J5LiBJdCBpcyBsaWtlbHkgdGhh
dCB0aGUgaG9zdCB3YXMgYWN0aXZlbHkgcmVkdWNpbmcgdGhlIG1lbW9yeSBhc3NpZ25lZCB0byB0
aGUgZ3Vlc3QgYW5kIHRoZXJlIHdhcyBzdWRkZW4gYnVyc3Qgb2YgcHJlc3N1cmUuIFBlcmhhcHMg
aW5jcmVhc2luZyB0aGUgbWluIG1lbW9yeSB3b3VsZCBoZWxwIHlvdSBjYXNlLg0KDQpLLiBZDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIFN0YW5sZXkgPGpvbnN0
YW5sZXlAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjUsIDIwMjEgMTowNyBQ
TQ0KPiBUbzogS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+IENjOiBIYWl5YW5n
IFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgU3RlcGhlbiBIZW1taW5nZXINCj4gPHN0
aGVtbWluQG1pY3Jvc29mdC5jb20+OyB3ZWkubGl1QGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBoeXBl
cnZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIGh2X2JhbGxvb24g
aXNzdWVzPz8NCj4gDQo+IE9uIE1vbiwgSmFuIDI1LCAyMDIxIGF0IDM6NTEgUE0gS1kgU3Jpbml2
YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSSB0YWtlIGl0IHRoYXQg
dGhpcyBpcyBvbiBXaW5kb3dzIFNlcnZlciBtYWNoaW5lLiBXaGF0IGFyZSB0aGUgRHluYW1pYw0K
PiBtZW1vcnkgc2V0dGluZ3MgZm9yIHRoZSBWTSB1bmRlciBxdWVzdGlvbi4NCj4gDQo+IE5vLCBz
b3JyeSBmb3IgbGVhdmluZyB0aGF0IG91dC4gVGhpcyBpcyBvbiBXaW5kb3dzIDEwIFBybyBmb3Ig
V29ya3N0YXRpb25zLCBvbiBhDQo+IFhlb24gVy0yMTU1IG1hY2hpbmUgd2l0aCAxOTJHQiBSQU0u
IEFwb2xvZ2llcyBidXQgSSdtIG1vcmUgb2YgYSBMaW51eCBndXkNCj4gdGhhbiBXaW5kb3dzIDop
LiBJZiBJJ3ZlIGdvdHRlbiB0aGUgd3JvbmcgdGhpbmcgbGV0IG1lIGtub3csDQo+IA0KPiBQUyBD
OlxVc2Vyc1xqb25zdD4gR2V0LVZNIC1WTU5hbWUgYnVpbGQtdGVzdDIgfEZvcm1hdC1MaXN0ICog
PHNuaXA+DQo+IENQVVVzYWdlICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogMA0KPiBNZW1v
cnlBc3NpZ25lZCAgICAgICAgICAgICAgICAgICAgICA6IDYwMzY2NTIwMzINCj4gTWVtb3J5RGVt
YW5kICAgICAgICAgICAgICAgICAgICAgICAgOiA1MTMwNjgyMzY4DQo+IE1lbW9yeVN0YXR1cyAg
ICAgICAgICAgICAgICAgICAgICAgIDogT0sNCj4gTnVtYUFsaWduZWQgICAgICAgICAgICAgICAg
ICAgICAgICAgOiBGYWxzZQ0KPiA8c25pcD4NCj4gRHluYW1pY01lbW9yeUVuYWJsZWQgICAgICAg
ICAgICAgICAgOiBUcnVlDQo+IE1lbW9yeU1heGltdW0gICAgICAgICAgICAgICAgICAgICAgIDog
MTA5OTUxMTYyNzc3Ng0KPiBNZW1vcnlNaW5pbXVtICAgICAgICAgICAgICAgICAgICAgICA6IDUz
Njg3MDkxMg0K
