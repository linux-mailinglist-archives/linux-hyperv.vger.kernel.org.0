Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF6696928
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Feb 2023 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBNQTe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Feb 2023 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBNQTd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Feb 2023 11:19:33 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C041C16D;
        Tue, 14 Feb 2023 08:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNQAZu8NMFZNZWrMboQm11YoWvVLSHF8FenJlo/u3BC1re3qcdmmTLB6lccdpQuT3goe8t4DpC96I0/1PeFok6UORPH0cxeO0Ji0O8vjV7MSdZI2jr8ZguKp6BglKDEz+j1S1toWt8lXk+2s3AZjpXakfsvV7rKVcif8XnKBnAXMGr6FnT/uOSMReBX3oqClVEWy6o2+xluX0Z1M52HjiEdMp9/D2G1/GRvCQdvo3qAkzavoVf3nzTd6rWIw5NNx1f1A/UIQ4vZJuzGAn/QGdAQtwBvEaydQzmk1721Fu61TW7QNaQ/FZB3juDALQfrjhh59YoCIyvbxYw86/ofz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cLqKZCV2EHjd79KkKL2fuqYYzDP+faObIMaIQECibE=;
 b=MkECGKysBRLhS6BdYgMBtoMt2oKUHReYX5cVo1L+oePP2qACiW5A7sL7b7XasyHirR+BLpHX7BzTrUJHt22Xt/EAYkRJvR5YVVAjPaaxVCkR6KBZRabrtL/Xx4or9FpanQXt63eNPVCljiwdn9uggZFNo2zm5JUDMAZ8U1oX+6Vsb/4KqPCd0A65okqZqOSH4/+3udEq2dfmxRVaVDthwaXSh4Vowtv/F99v5SyAQlC8XFQYyAq++/yP9xRf59+izwiSf92yVpFJ5vlAUp8bn1HZbpZI7uPgHbImgFL4EoP40+uNIKTj3b0GIwnRPQGnDsOfTpfblYKF9KyUnFhgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cLqKZCV2EHjd79KkKL2fuqYYzDP+faObIMaIQECibE=;
 b=Mmu295vYN1ozXhVWId9u0xyQrFzfN+U1pCd7f9FBWwqZ9b/9f2kVYsaTBoK4kxD8BdSkmiC/RP9HUxudXVKAU8TAujSwVqKsv1sJjAc9Ou9n+Njt75iMlJDdcgnuVjS89rkki/eytzhKO6muuCM0mECUViqaoAZmVtU+NoDUdNs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1957.namprd21.prod.outlook.com (2603:10b6:510:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.3; Tue, 14 Feb
 2023 16:19:14 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%8]) with mapi id 15.20.6134.003; Tue, 14 Feb 2023
 16:19:14 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Thread-Topic: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Thread-Index: AQHZOmyDXwNyD+qOhEijfVFgcoX9l67OqFMg
Date:   Tue, 14 Feb 2023 16:19:13 +0000
Message-ID: <BYAPR21MB16881C783D58F2F20B7E196DD7A29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=01af5a1e-573f-46d4-bad2-b2b9f7a29b7b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-14T16:08:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1957:EE_
x-ms-office365-filtering-correlation-id: 56f82f84-304a-4471-f9ea-08db0ea7365a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RSc/bxcfAD5OT4yKJQ9y6Dx1AfiHHVOKVYN5u2gKLNuI5e42HEaC7cU4OGrjWIkwZmgSV/WCEXSkkr+LmBUyiVFJcpkJCe5EPur/ch171CwAtsiusatmwqOFcyBkqHu8gJpV/C6HvXxKxfIIMBcTKHHJvPPoTTTUmMF20iH2nx8sAt5JKTxtMBu1iIKd88I4MG0OEEX3QWaiCRkFkeKtDR6cqCVBfA7iTW6RlOhzu6uU8FgFffmARKN1ApYCeJDIFP54PPoU3n2iVKDUeV0QAqIyezeiB8AGSX6r9/CwLBWWvNQf+q2gGCic+J0nuTodHxEBwHIPab/L5PNLiPE6LSn5cZxDCf5Q75k7cATbtv1+/s3+gntG1++JMI3NaznX/NEWiQt8W4G7gbSXSgB8B0fLqvhsQyOVca3z3bnbdsiCj3ZvILAIOACGXASDPvhkAkIN0iVv7g9WBf4lU2Rvdd4TIDM19+3edpgu2L2SOEr2yLjiKrogyhEdCNFgeaDoKTihn9xmpPMvA/nTRuXo6qTiRQwN3Zjq3vH8xe5WeyeyaIdCnZF3ywK1fJXACLjmv4ECC2iIrPEcfgJIkrq1PQyckQ3RIXBb3ApYHYRrlKM8/L4YsB4aeSddLWRp4kngY/1oaR8LcL6jkqPTGklb8rzEqRSCqXojP6BbZlYY77mWsqbcvtBubLaoMjKOtudHf9Mixhpl5xxaARkwlK+4QtePdxV2lW24dq0C+AnFOTP6JJ5j+3zQgRwoqvE3j88
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(8990500004)(71200400001)(478600001)(7696005)(55016003)(83380400001)(82950400001)(82960400001)(86362001)(38070700005)(122000001)(38100700002)(33656002)(9686003)(6506007)(186003)(76116006)(41300700001)(7416002)(5660300002)(66946007)(6862004)(10290500003)(4326008)(8936002)(52536014)(316002)(64756008)(8676002)(66446008)(54906003)(66556008)(66476007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2I2QVYraDBrcmpnNkorVkdyU21PRG1OVFFGajlydlhIVXk5ZHliU2NSRFE3?=
 =?utf-8?B?ZG0xUko4K3F2VVUwTisvV0FodU5LaEFYYVQ1Znp5dktWOGdzbWU4azJGUlli?=
 =?utf-8?B?M204bGgrT082eUhtNmY2YkJyVXJMSzBFWHQ0Uk1KNHVMMWd6Q0YrWGxEcHNE?=
 =?utf-8?B?UTZsV2pVYkFUalVzeTIvU2diUlFpSDJUUEtuNVZnS2dVMXd0cWI2cHpISldN?=
 =?utf-8?B?NklpeFc3L2NRemc2V2xKUW9rSzdOUVlFUTU1d1VtWWlqWG5ReHl5V21Sdnl5?=
 =?utf-8?B?dDg0V3Q2MXlUekVDZHpDYkxnQ3lkSVAxWGNCRlEvb0dPVkZGdVo0SmRsdEhW?=
 =?utf-8?B?Q3VPZUROdUVLUDRwZzNPdmJabnBqOU9tYzdtN2RWTTEzMWEyYVhWUkVsUUNV?=
 =?utf-8?B?YUNoT0IrRGU4NGptbUZCdXQ5cVJlWFRRVThGUjlBNGgrVjA0RUZrb3VuTzl4?=
 =?utf-8?B?Z2tEd29jZHVGS3RsVWQ0T2IzaWgwMUh3VFZBMTV1UkVZcG44NG80YVpJcC9j?=
 =?utf-8?B?RmowTUhmanNLZktmSXc5dmdaR2RYTlFKT1FaOU1LMG82eEZ5MjBDZEdlSkZ0?=
 =?utf-8?B?cUYwNHZ3WnJwS3QxV0VCbklzU1RnVWdIcjlWYzFtZ1FTQktqY3hqdWMxZC9K?=
 =?utf-8?B?WGVqdkNZYTEvRWFjYVFIT1hFVGkxQ2YvT0RMTFpOTlYvODF3dmpzMWF1SnRL?=
 =?utf-8?B?YjIrOGE5dGhJV2dsN2ErTDZxeGVteGpuQ3BMbEQ1c1l0QzEwalA2SUVSMVV4?=
 =?utf-8?B?bGhxTmtkY0Z5V1ZmbUtkeUxyOTQ3NWlPNDNycG5IWk56V3JPKzByZEpmMTdy?=
 =?utf-8?B?YmtLN1Y0UE1LVDhmcjhWckt1Q3dKKzZIL2d3d3pRSkkxZHU2R2l6OWx0TG5k?=
 =?utf-8?B?UG5kb3VwYUtpdjE0eXRHb0pwNHh2T0prc2R1QURmSGh1RkJJcFY2b2JDUU5V?=
 =?utf-8?B?cGRySzZhMkExNWZKcGVyQWFjSHhDalRaYk1lV1JmM2FFYU1GSG1EdWlmOHhk?=
 =?utf-8?B?MnNjQlN2SVQ2d09oTE1VNVB6OE9ndUloNEFuRFRFeG5Zd2hyVGNNS1l3blBz?=
 =?utf-8?B?UVZhTmJ1WTlxYytrK2NSZmhmU2laNXhBUUVqTVg4VUdMUzMxL1JTVHVSb2pw?=
 =?utf-8?B?Mmo5U2J0cmY1MUhMeUtQaDhHcnowY2tZWUpyTGw4eTJ4eTFVVFJoVnhTVFBt?=
 =?utf-8?B?LzhmSTg4V000ZjhCNml2NnBaYWw0eXlzeDZRV21ySXlWMVJjWlVQczVCUmE3?=
 =?utf-8?B?SHpsTUhSS053UzVYd1hmMEErcjFqSDQ5ekdWcVJYZGpoaGg5UW5nOUo2Y0tq?=
 =?utf-8?B?TkFSbzVBZWQ3MDhxVldQd0tjcWlYckR3ZCs5ZzBnZ1JlRXFwU0pFeVNYM1Nt?=
 =?utf-8?B?WE9hWEprM2VMWFZKL1h6NGdWTFVkZTAzZE1rYlVVV3dSVFNnaTRSVlh2clpY?=
 =?utf-8?B?N2I0VlpmalBPTklzMTAzQlRRTE9TTWtiVUNMS3RWNFFWRzJBZHVjY2orNVFa?=
 =?utf-8?B?WVVidytiWDVMQTZvcDJRaU5HQW9ZcHBOb1JoR2FzNG94VFc5ZnNDOEZWbWk4?=
 =?utf-8?B?bzUzUEhVSjVmdjFnN0xKUWZGNkt6eG5DTDEvUm9PRFR0c0dnczV0d1IxdzE1?=
 =?utf-8?B?dzR0TG9VdEpIK0xINmtDU3lVbkxBVHRPWFNLdWZ6bFJxUEEwOUwwQVY3WXYz?=
 =?utf-8?B?UlZEcjlMZU5VMmFRdEVzbTNvcitVakZQcGlib1ZEdjN6OUhrVnRJU1ZEbnhm?=
 =?utf-8?B?VlkyMnM0RDhoYkVUd1hZeWVyMngzamxBUFgrdmJvRjd2ZW5yT1VESzgwQjRE?=
 =?utf-8?B?cTFkbFU2bG9mQnFwb1F3MVBEanJSaWVnY1lxdFNuMzhheEQ3UENOTlVjMFF1?=
 =?utf-8?B?MEF4bGtJeER6NWhaSTZOUk94cVJRR1k0YTRhYkcvWTlBdkR2clpFOUdqTDgv?=
 =?utf-8?B?ekJvc0ZyOUNET2hOL201USs5SWdVQ2Y1dXlaN3dGZ0dwNEdkZFhDZFVQbTVM?=
 =?utf-8?B?ZW5HQ0N6Smx2NU5sMnVreHErYTIrZXkwVk92YzYzdkVqejgxdXRRMnlSaWFi?=
 =?utf-8?B?SjJIYVZTdmQ4SzVoNVFzYndwb3FXOWdXSXV3Y2J6THFVNWdFRnRJeHdoUGRD?=
 =?utf-8?B?K3IwZzZGMzk1Z3RKd05aSFNlVkJESkRlb3lNSEZoakFQS2JQdjh0TW5mclNQ?=
 =?utf-8?B?Vkw5VjVRMllFSjlMVG9XY1pKZzcyM1ZpUHdmUFhuYzlZSFNGK3pjVGhLV3Y0?=
 =?utf-8?B?UkJNUlJzS3UvZUsxR0UyY3c2ZXNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f82f84-304a-4471-f9ea-08db0ea7365a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 16:19:13.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kOcB2ZnHm1WXfb63zKl17M5ePaYqKNEjf9P56pAZHhM9J5sPpVH64zvLYT8R7vlIAggQB+8yXnbXeXvi/nC9nJ0QNGZeJQevAOvv82tsck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4NCj4gDQo+IEFuZCBoYXZlIGl0IHByZXNldC4NCj4gVGhpcyBjaGFuZ2UgYWxsb3dzIHRv
IHNpZ25pZmljYW50bHkgcmVkdWNlIHRpbWUgdG8gYnJpbmcgdXAgZ3Vlc3QgU01QDQo+IGNvbmZp
Z3VyYXRpb24gYXMgd2VsbCBhcyBtYWtlIHN1cmUgdGhlIGd1ZXN0IHdvbid0IGdldCBpbmFjY3Vy
YXRlDQo+IGNhbGlicmF0aW9uIHJlc3VsdHMgZHVlIHRvICJub2lzeSBuZWlnaGJvdXIiIHNpdHVh
dGlvbi4NCj4gDQo+IEJlbG93IGFyZSB0aGUgbnVtYmVycyBmb3IgMTYgVkNQVSBndWVzdCBiZWZv
cmUgdGhlIHBhdGNoICh+MTMwMCBtc2VjKQ0KPiANCj4gWyAgICAwLjU2MjkzOF0geDg2OiBCb290
aW5nIFNNUCBjb25maWd1cmF0aW9uOg0KPiAuLi4NCj4gWyAgICAxLjg1OTQ0N10gc21wOiBCcm91
Z2h0IHVwIDEgbm9kZSwgMTYgQ1BVcw0KPiANCj4gYW5kIGFmdGVyIHRoZSBwYXRjaCAofjEzMCBt
c2VjKToNCj4gDQo+IFsgICAgMC40NDUwNzldIHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlv
bjoNCj4gLi4uDQo+IFsgICAgMC41NzUwMzVdIHNtcDogQnJvdWdodCB1cCAxIG5vZGUsIDE2IENQ
VXMNCj4gDQo+IFRoaXMgY2hhbmdlIGlzIGluc3BpcmVkIGJ5IGNvbW1pdCAwMjkzNjE1ZjNmYjkg
KCJ4ODY6IEtWTSBndWVzdDogdXNlDQo+IHBhcmF2aXJ0IGZ1bmN0aW9uIHRvIGNhbGN1bGF0ZSBj
cHUga2h6IikuDQoNClRoaXMgcGF0Y2ggaGFzIGJlZW4gbmFnZ2luZyBhdCBtZSBhIGJpdCwgYW5k
IEkgZmluYWxseSBkaWQgc29tZSBmdXJ0aGVyDQpjaGVja2luZy4gICBMb29raW5nIGF0IExpbnV4
IGd1ZXN0cyBvbiBsb2NhbCBIeXBlci1WIGFuZCBpbiBBenVyZSwgSSBzZWUNCmEgZG1lc2cgb3V0
cHV0IGxpbmUgbGlrZSB0aGlzIGR1cmluZyBib290Og0KDQpDYWxpYnJhdGluZyBkZWxheSBsb29w
IChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiA1MTg3
LjgxIEJvZ29NSVBTIChscGo9MjU5MzkwNSkNCg0KV2UncmUgYWxyZWFkeSBza2lwcGluZyB0aGUg
ZGVsYXkgbG9vcCBjYWxjdWxhdGlvbiBiZWNhdXNlIGxwal9maW5lDQppcyBzZXQgaW4gdHNjX2lu
aXQoKSwgdXNpbmcgdGhlIHJlc3VsdHMgb2YgZ2V0X2xvb3BzX3Blcl9qaWZmeSgpLiAgVGhlDQps
YXR0ZXIgZG9lcyBleGFjdGx5IHRoZSBzYW1lIGNhbGN1bGF0aW9uIGFzIGh2X3ByZXNldF9scGoo
KSBpbg0KdGhpcyBwYXRjaC4NCg0KSXMgdGhpcyBwYXRjaCBhcmlzaW5nIGZyb20gYW4gZW52aXJv
bm1lbnQgd2hlcmUgdHNjX2luaXQoKSBpcw0Kc2tpcHBlZCBmb3Igc29tZSByZWFzb24/ICBKdXN0
IHRyeWluZyB0byBtYWtlIHN1cmUgd2UgZnVsbHkNCndoZW4gdGhpcyBwYXRjaCBpcyBhcHBsaWNh
YmxlLCBhbmQgd2hlbiBub3QuDQoNCk1pY2hhZWwNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Rh
bmlzbGF2IEtpbnNidXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBD
QzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IEhhaXlhbmcg
WmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+IENDOiBXZWkgTGl1IDx3ZWkubGl1QGtl
cm5lbC5vcmc+DQo+IENDOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDQzog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBJbmdvIE1vbG5hciA8
bWluZ29AcmVkaGF0LmNvbT4NCj4gQ0M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0K
PiBDQzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ0M6IHg4
NkBrZXJuZWwub3JnDQo+IENDOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBD
QzogbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZw0KPiBDQzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyB8ICAg
MjEgKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYw0KPiBpbmRleCBkZWRlYzJmMjNhZDEuLjAy
ODJiMmU5NmNjMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5j
DQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYw0KPiBAQCAtMzIwLDYgKzMy
MCwyMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaHZfc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBp
bnQNCj4gbWF4X2NwdXMpDQo+ICB9DQo+ICAjZW5kaWYNCj4gDQo+ICtzdGF0aWMgdm9pZCBfX2lu
aXQgX19tYXliZV91bnVzZWQgaHZfcHJlc2V0X2xwaih2b2lkKQ0KPiArew0KPiArCXVuc2lnbmVk
IGxvbmcga2h6Ow0KPiArCXU2NCBscGo7DQo+ICsNCj4gKwlpZiAoIXg4Nl9wbGF0Zm9ybS5jYWxp
YnJhdGVfdHNjKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlraHogPSB4ODZfcGxhdGZvcm0uY2Fs
aWJyYXRlX3RzYygpOw0KPiArDQo+ICsJbHBqID0gKCh1NjQpa2h6ICogMTAwMCk7DQo+ICsJZG9f
ZGl2KGxwaiwgSFopOw0KPiArCXByZXNldF9scGogPSBscGo7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyB2b2lkIF9faW5pdCBtc19oeXBlcnZfaW5pdF9wbGF0Zm9ybSh2b2lkKQ0KPiAgew0KPiAgCWlu
dCBodl9tYXhfZnVuY3Rpb25zX2VheDsNCj4gQEAgLTUyMSw2ICs1MzYsMTIgQEAgc3RhdGljIHZv
aWQgX19pbml0IG1zX2h5cGVydl9pbml0X3BsYXRmb3JtKHZvaWQpDQo+IA0KPiAgCS8qIFJlZ2lz
dGVyIEh5cGVyLVYgc3BlY2lmaWMgY2xvY2tzb3VyY2UgKi8NCj4gIAlodl9pbml0X2Nsb2Nrc291
cmNlKCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFByZXNldCBscGogdG8gbWFrZSBjYWxpYnJhdGVf
ZGVsYXkgYSBuby1vcCwgd2hpY2ggaXMgdHVybiBoZWxwcyB0bw0KPiArCSAqIHNwZWVkIHVwIHNl
Y29uZGFyeSBjb3JlcyBpbml0aWFsaXphdGlvbi4NCj4gKwkgKi8NCj4gKwlodl9wcmVzZXRfbHBq
KCk7DQo+ICAjZW5kaWYNCj4gIAkvKg0KPiAgCSAqIFRTQyBzaG91bGQgYmUgbWFya2VkIGFzIHVu
c3RhYmxlIG9ubHkgYWZ0ZXIgSHlwZXItVg0KPiANCg0K
