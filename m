Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D069F3F7C91
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbhHYTMJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 15:12:09 -0400
Received: from mail-centralus02namln2009.outbound.protection.outlook.com ([40.93.8.9]:44575
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242469AbhHYTMH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 15:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFn1Z19dXveBmOPSuZAs2SvBumkspaUWvS7S8pxRdt32SN4NlGDuPBXVOQk3WsHW+P1v74pxlH9PSj5vLgxW1K75y+ihBpzPyBnebpiy9VO9E4DU6CIb/4wDlfHBm2OyiNTLHy6ElxDkqCe8Hn6rwN3mF4WoP8nM4ju8RwRgBSBX+caMK3L0aD/v+vftDZEA7hUZyqqhTm2AfoW2DCyILqA/wNPj6Kl+JkNfDWiCgZIMaONyaDvAA/bEJt8+yqtTF6QKQS0lHsbQzpmjPS99pwHty2rZqSmQ/ya8JaCNW6em6ixY68+L4CM9nHDCW3LS0X819TMqZeBg3l1GLDfDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mt7k1rn0fyHNYAdDp4J4+UIsnLcVEq7wXxVSrZA/uuQ=;
 b=iBaCw449WNhZaJDVAo6r6yfkla7xUUqaoqbtnjzmBCI8ei488fg+ZBPaURMrVF6mfrkU0w614jmAT6ct2k7ZrIWPazHFOoH2D+epVITDhc6AzLYR4Cn3k2LqzVgSx2Jn6+49mYjhQwZdiiqSWCIk0WsiQbIRUjCQ+vU8zqj0v2dAqCoyREBCr9bW8uiAqbv5hlRJ+ezgYecDersPtOwfnGJEqKEoPGrbaM3bBotPLICOqewIGD6IRwc9DZ0dFElC6HcX/nXmjGuNPujqa5rkClua9E5jxt1DUCal+KRZi5sDH6Aif1BBGHL+TfiRWU18zGGG4MX5Q5bC2c6ev5/yJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt7k1rn0fyHNYAdDp4J4+UIsnLcVEq7wXxVSrZA/uuQ=;
 b=APPN8dESMTy1w0OCJcmkqvFDC84JBkZVpGxlF74DudNpM2yXDuCmaWr/m4bEzPlFsi9vBXqHF6FfnhTUzM8/XwlwGX4biyq3nV4WTur2+UXGEUYo63NxzVdWO9LXkohlyiMxWxaNb2YbQWrKxVEXxBkaX85OfY5gqsqnvmoFSrA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0477.namprd21.prod.outlook.com (2603:10b6:300:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.5; Wed, 25 Aug
 2021 19:11:18 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.004; Wed, 25 Aug 2021
 19:11:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiESLmzOYeb6EiXQYn0jJPYeauCfYUAgABr14CAAa0jQA==
Date:   Wed, 25 Aug 2021 19:11:17 +0000
Message-ID: <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8eb6a14f-f3c0-4df9-987b-c38e40597571;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T17:27:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefcf42e-dfaa-4dec-67fe-08d967fc1de3
x-ms-traffictypediagnostic: MWHPR21MB0477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0477453213A768A895DBF367D7C69@MWHPR21MB0477.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBeg0fUf3B9BE8oYKHY6uVoVCrsjEtL8nRcVPbt6SH/9WaPtcig8s/sKwAHOXOHAo9LNWUWBmjM2UuuUp9nkQdhyQu6I9ZhnnI7leDllFjyBLPwqAdKH7Ion+34yl8Zd4yC0a0nCTSKx8uHJVoYG1/YLmXaxlbN/mlBYr29LAjcyQZBwRjIUcXlrmoaU4Vn9+4+mn1Is0Gj+2FU+vGBtsTEf6CqAQi20T1cj9ch/aH9QX/aHRxft+saf6SKSzCudvIU5S3isJn3AceBbUeInGILWLwqBhkEfvmEYteBYHP8sMrRYyHJjDlGws7m+j2TYPS+crVK1DmxQBQMvMIJHF6nsUvF07QICej3umrRd+zdMUG4sAHg74qiZl9hrmGP2NXMN+ncgSpscICiU4E95+o7+Rz64TxAxNwp4D1OMaLwAfuHf+PxbBE7AkrMu31lx+brXUN0gahwhvCadknFTO4hd9lC+0/1JT5k8BHDRkW8RimxLt8EQnBSJDexG70v8eHMtDE5XOqizviPvj6oQ2ZOXZsekxebjxtwdLiS13yjHHX0yl60eKaTXltgRsNbKxpgtYHyqP85MLmFlG0+Pk49h99ZuqiA+yX1fyBfzTFZdmwXJwe2pTNgeD8jCoF8xt8c08FLRw1PqWvnfj4EDrACir7Pb8unpRL9XoX1DdeieSCzBdXzhxUhjep1/2EDP1kcfL2lXzpp2XCrlYViqWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66946007)(76116006)(66556008)(64756008)(53546011)(66446008)(8676002)(66476007)(186003)(10290500003)(7416002)(6506007)(26005)(508600001)(82950400001)(82960400001)(2906002)(7696005)(8936002)(38070700005)(52536014)(316002)(71200400001)(33656002)(86362001)(83380400001)(110136005)(8990500004)(38100700002)(9686003)(5660300002)(55016002)(66574015)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNpSk5aQWRXdVR6bzJqM3V4amtlZk84aHFSSnN5d3YvM2ZhVEE1ZzBiRUxJ?=
 =?utf-8?B?T0ZnemZpZStQdnJ0c2VHVjJJemtDZjdWOVNqTjlGdmluRzV2Z0NhdTdzL3Zu?=
 =?utf-8?B?a3NIeUVzUk0rTVJ1bGwvc3ZLbmxnRnZzenZjYmIwQkRzRkZ3TzdONk1nd3lZ?=
 =?utf-8?B?eCsxV2s0MVhEenJ3YmRpczJMWGN2akF5RU5XSTZWbWRETU1QbFZ6VkJLaG0v?=
 =?utf-8?B?eXNVa1VmMHZiNjhqd2FHV0l6MWlFR1c0dnBkTFBGMStGSlZlZkpjYXN1RDZZ?=
 =?utf-8?B?T3VueWllWVA2cTI0cTBRYVl5SmNHWTI0KzRDZ1JjVVZoS3JTSXVmR3dkYVpQ?=
 =?utf-8?B?OE1BN0VSSk1pRTRXSWI3ZjE4b1hTR1ZhdGZOc3BVYndCS1lNQVhuY3pMTTNu?=
 =?utf-8?B?WUVqdDRQOUo2eGk3RTF0NFQ0Rk52dHpPWndvZ1ZjcU5QYk1hZVNNdVJPZXFJ?=
 =?utf-8?B?TUpIUHNXMFVUWjBDWjJsaVUzbVJxdkQzeHRuTWxSRFQ0TGFieGtseGhrajdw?=
 =?utf-8?B?R2ZtM2FvVHQ1UHNXUU5KZDBhai81QWNpekh4TUtxZXROV1VEdnVMNVZZMUNz?=
 =?utf-8?B?ajEya1hTS1d6dnJTcnBKMWdKQ0dXNGpnUHhFLy9QMHBsSzUxUlVRUXZXaFF0?=
 =?utf-8?B?ZW1yQ1IvSTFYeldXWHB2ekQxN1Q5b21FL0lEM0IzRkEzempseis1aCtaRDdT?=
 =?utf-8?B?U2krNTBrWUxibFQwU25HaldDNnRwZ2dIOERPcFVscG5NOGVtS01ma0NoU1pm?=
 =?utf-8?B?V0tENFZNdUF2V2c1bDBrTUVvRy9UWENuK0s5QXErMFhCVC9telFjRitNV3JD?=
 =?utf-8?B?cVh6K2pXSGFaVklDN3BlL2ZPRjF1US9QbmFJaXM5aWE0cVdCMW1MMzVDdEdl?=
 =?utf-8?B?dzMxSEljVXZjblJXU0NaWC9xNHROUkRNUGVZQ2hyNEw1clE5RW93YU4wYVRI?=
 =?utf-8?B?d0lFeEJVUVVlS214b3hsaVU5N3U1TmJIRDRNYlQzN1BEbFIyQmJsakxZV0RU?=
 =?utf-8?B?WFA2d2JJUkhvZmhOWFg3NVRUeTdkbWV6R3Qrd2FPTWc3WGFESTYzUVdYbnhV?=
 =?utf-8?B?WkExcmhUeUFtcUFlck82Q0VvbkhhbmhUa0hER05NZVJuOU82RWRrREpscUo2?=
 =?utf-8?B?M0E2TW5VL2lVL0VheGJTRThtTW5RWEdLZTRTU3d3NEhhOTFhYVkyYWpZTG9n?=
 =?utf-8?B?RXJyNUNZUUZScnF4ZUg2RzdsZWZ6dUhJQ3pjSnpWdUNmeng5ZTBzdWpCNEVD?=
 =?utf-8?B?RStrWU1pU0szRWdrM1JkMTBwTHl1d1VrdUNWYU5oeDBDOHI2OE5aREppZnp2?=
 =?utf-8?B?d3NTVnViaUFRMnozcUM1aDNnZVNIMmlPZnFnaW91YmpocHJmRFh4SVJBV25D?=
 =?utf-8?B?NVdwSDJGbEpvdTlsRTlLUmFTZWpZbHVRNlNjVmNkOGErdUJxbDcyMG9Xa0h1?=
 =?utf-8?B?NkVpbkdJSHQ2YWRNdUhWdGdIUUxRYmd6NWNoM2xEUmVFcHhHd1RvYlJKOVVh?=
 =?utf-8?B?VUhCTEl1ZTZZc1JJRXZWSG96eDhDMVhRMUtOOGVTY1pzejBTRWxRM0lsMFFj?=
 =?utf-8?B?cVhXQ050Q0VIK3JEQldRS2VYcDNVbGM4THB0R3pndGtUNTJ1cXpkMnRNVlUx?=
 =?utf-8?B?TURWbFhsMDV1K0Jyai9nd3lLbXRMdnp1aFNrWDlzQW8wUDM5NWtjb1BSTVgw?=
 =?utf-8?B?VzhhUUowMXlyVXNsZXdlRHBjRWl5cjJuMVlETUxOQm5hd1grdFphcmsxeGFx?=
 =?utf-8?Q?cmpMtAeVGNEm1CyhPVdd2mdnWzYncFfpjUzIDqa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefcf42e-dfaa-4dec-67fe-08d967fc1de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 19:11:17.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ad/yAd0rSjaa9IPEJdIVtX8NAt3r2vrJia6jaFxJmK1OGpN9KSgCToLBMkCcCM3kzGvpfDtR4KDSZTu3h3zv/3ovYOei0AFnBWls7K8ABc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+IFNlbnQ6IFR1ZXNkYXksIEF1Z3Vz
dCAyNCwgMjAyMSAxMDoyOCBBTQ0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGh2
OiBGaXggYSBidWcgb24gcmVtb3ZpbmcgY2hpbGQgZGV2aWNlcyBvbiB0aGUgYnVzDQo+ID4NCj4g
PiBPbiBUdWUsIEF1ZyAyNCwgMjAyMSBhdCAxMjoyMDoyMEFNIC0wNzAwLCBsb25nbGlAbGludXhv
bmh5cGVydi5jb20gd3JvdGU6DQo+ID4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0
LmNvbT4NCj4gPiA+DQo+ID4gPiBJbiBodl9wY2lfYnVzX2V4aXQsIHRoZSBjb2RlIGlzIGhvbGRp
bmcgYSBzcGlubG9jayB3aGlsZSBjYWxsaW5nDQo+ID4gPiBwY2lfZGVzdHJveV9zbG90KCksIHdo
aWNoIHRha2VzIGEgbXV0ZXguDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBub3Qgc2FmZSBmb3Igc3Bp
bmxvY2suIEZpeCB0aGlzIGJ5IG1vdmluZyB0aGUgY2hpbGRyZW4gdG8gYmUNCj4gPiA+IGRlbGV0
ZWQgdG8gYSBsaXN0IG9uIHRoZSBzdGFjaywgYW5kIHJlbW92aW5nIHRoZW0gYWZ0ZXIgc3Bpbmxv
Y2sgaXMNCj4gPiA+IHJlbGVhc2VkLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA5NGQyMjc2MzIwN2Eg
KCJQQ0k6IGh2OiBGaXggYSByYWNlIGNvbmRpdGlvbiB3aGVuIHJlbW92aW5nIHRoZQ0KPiA+ID4g
ZGV2aWNlIikNCj4gPiA+DQo+ID4gPiBDYzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWljcm9z
b2Z0LmNvbT4NCj4gPiA+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29t
Pg0KPiA+ID4gQ2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPg0K
PiA+ID4gQ2M6IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBEZXh1YW4g
Q3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gQ2M6IExvcmVuem8gUGllcmFsaXNpIDxs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPg0KPiA+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+DQo+ID4gPiBDYzogIktyenlzenRvZiBXaWxjennFhHNraSIgPGt3QGxpbnV4LmNv
bT4NCj4gPiA+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+ID4g
Q2M6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gQ2M6IERh
biBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiA+IFJlcG9ydGVkLWJ5
OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jIHwgMTUgKysrKysrKysrKysrLS0t
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5
cGVydi5jDQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4g
PiBpbmRleCBhNTNiZDg3MjhkMGQuLmQ0ZjNjY2UxODk1NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+ID4gQEAgLTMyMjAsNiArMzIyMCw3IEBAIHN0
YXRpYyBpbnQgaHZfcGNpX2J1c19leGl0KHN0cnVjdCBodl9kZXZpY2UgKmhkZXYsDQo+ID4gYm9v
bCBrZWVwX2RldnMpDQo+ID4gPiAgCXN0cnVjdCBodl9wY2lfZGV2ICpocGRldiwgKnRtcDsNCj4g
PiA+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ICAJaW50IHJldDsNCj4gPiA+ICsJc3Ry
dWN0IGxpc3RfaGVhZCByZW1vdmVkOw0KPiA+DQo+ID4gVGhpcyBjYW4gYmUgbW92ZWQgdG8gd2hl
cmUgaXQgaXMgbmVlZGVkIC0tIHRoZSBpZigha2VlcF9kZXYpIGJyYW5jaCAtLSB0byBsaW1pdCBp
dHMNCj4gPiBzY29wZS4NCj4gPg0KPiA+ID4NCj4gPiA+ICAJLyoNCj4gPiA+ICAJICogQWZ0ZXIg
dGhlIGhvc3Qgc2VuZHMgdGhlIFJFU0NJTkRfQ0hBTk5FTCBtZXNzYWdlLCBpdCBkb2Vzbid0IEBA
DQo+ID4gPiAtMzIyOSw5ICszMjMwLDE4IEBAIHN0YXRpYyBpbnQgaHZfcGNpX2J1c19leGl0KHN0
cnVjdCBodl9kZXZpY2UgKmhkZXYsIGJvb2wNCj4gPiBrZWVwX2RldnMpDQo+ID4gPiAgCQlyZXR1
cm4gMDsNCj4gPiA+DQo+ID4gPiAgCWlmICgha2VlcF9kZXZzKSB7DQo+ID4gPiAtCQkvKiBEZWxl
dGUgYW55IGNoaWxkcmVuIHdoaWNoIG1pZ2h0IHN0aWxsIGV4aXN0LiAqLw0KPiA+ID4gKwkJSU5J
VF9MSVNUX0hFQUQoJnJlbW92ZWQpOw0KPiA+ID4gKw0KPiA+ID4gKwkJLyogTW92ZSBhbGwgcHJl
c2VudCBjaGlsZHJlbiB0byB0aGUgbGlzdCBvbiBzdGFjayAqLw0KPiA+ID4gIAkJc3Bpbl9sb2Nr
X2lycXNhdmUoJmhidXMtPmRldmljZV9saXN0X2xvY2ssIGZsYWdzKTsNCj4gPiA+IC0JCWxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShocGRldiwgdG1wLCAmaGJ1cy0+Y2hpbGRyZW4sDQo+ID4gbGlz
dF9lbnRyeSkgew0KPiA+ID4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGhwZGV2LCB0bXAs
ICZoYnVzLT5jaGlsZHJlbiwNCj4gPiBsaXN0X2VudHJ5KQ0KPiA+ID4gKwkJCWxpc3RfbW92ZV90
YWlsKCZocGRldi0+bGlzdF9lbnRyeSwgJnJlbW92ZWQpOw0KPiA+ID4gKwkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KPiA+ID4gKw0KPiA+
ID4gKwkJLyogUmVtb3ZlIGFsbCBjaGlsZHJlbiBpbiB0aGUgbGlzdCAqLw0KPiA+ID4gKwkJd2hp
bGUgKCFsaXN0X2VtcHR5KCZyZW1vdmVkKSkgew0KPiA+ID4gKwkJCWhwZGV2ID0gbGlzdF9maXJz
dF9lbnRyeSgmcmVtb3ZlZCwgc3RydWN0IGh2X3BjaV9kZXYsDQo+ID4gPiArCQkJCQkJIGxpc3Rf
ZW50cnkpOw0KPiA+DQo+ID4gbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlIGNhbiBhbHNvIGJlIHVz
ZWQgaGVyZSwgcmlnaHQ/DQo+ID4NCj4gPiBXZWkuDQo+IA0KPiBJIHdpbGwgYWRkcmVzcyB5b3Vy
IGNvbW1lbnRzLg0KPiANCj4gTG9uZw0KDQpJIHRob3VnaHQgbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKCkgaXMgZm9yIHVzZSB3aGVuIGxpc3QgbWFuaXB1bGF0aW9uDQppcyAqbm90KiBwcm90ZWN0
ZWQgYnkgYSBsb2NrIGFuZCB5b3Ugd2FudCB0byBzYWZlbHkgd2FsayB0aGUgbGlzdA0KZXZlbiBp
ZiBhbiBlbnRyeSBnZXRzIHJlbW92ZWQuICBJZiB0aGUgbGlzdCBpcyBwcm90ZWN0ZWQgYnkgYSBs
b2NrIG9yDQpub3Qgc3ViamVjdCB0byBjb250ZW50aW9uIChhcyBpcyB0aGUgY2FzZSBoZXJlKSwg
dGhlbg0KbGlzdF9mb3JfZWFjaF9lbnRyeSgpIGlzIHRoZSBzaW1wbGVyIGltcGxlbWVudGF0aW9u
LiAgVGhlIG9yaWdpbmFsDQppbXBsZW1lbnRhdGlvbiBkaWRuJ3QgbmVlZCB0byB1c2UgdGhlIF9z
YWZlIHZlcnNpb24gYmVjYXVzZSBvZg0KdGhlIHNwaW4gbG9jay4NCg0KT3IgZG8gSSBoYXZlIGl0
IGJhY2t3YXJkcz8gIA0KDQpNaWNoYWVsDQoNCj4gDQo+ID4NCj4gPiA+ICAJCQlsaXN0X2RlbCgm
aHBkZXYtPmxpc3RfZW50cnkpOw0KPiA+ID4gIAkJCWlmIChocGRldi0+cGNpX3Nsb3QpDQo+ID4g
PiAgCQkJCXBjaV9kZXN0cm95X3Nsb3QoaHBkZXYtPnBjaV9zbG90KTsNCj4gPiA+IEBAIC0zMjM5
LDcgKzMyNDksNiBAQCBzdGF0aWMgaW50IGh2X3BjaV9idXNfZXhpdChzdHJ1Y3QgaHZfZGV2aWNl
ICpoZGV2LA0KPiA+IGJvb2wga2VlcF9kZXZzKQ0KPiA+ID4gIAkJCXB1dF9wY2ljaGlsZChocGRl
dik7DQo+ID4gPiAgCQkJcHV0X3BjaWNoaWxkKGhwZGV2KTsNCj4gPiA+ICAJCX0NCj4gPiA+IC0J
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhidXMtPmRldmljZV9saXN0X2xvY2ssIGZsYWdzKTsN
Cj4gPiA+ICAJfQ0KPiA+ID4NCj4gPiA+ICAJcmV0ID0gaHZfc2VuZF9yZXNvdXJjZXNfcmVsZWFz
ZWQoaGRldik7DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
