Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15B7201F6
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjFBMWU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFBMWT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 08:22:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8271B1;
        Fri,  2 Jun 2023 05:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHOn+kAZbS2aOUd/fjVg0ZEl55jk1Mq3t2zfiJBeKi/r823JwViftL0IODWasoBODCg8r1mt+kPUuPGRMryeOXuieb5hxElU0qMaWrctuFNbO5+EghQsBiE05Scy2+HRR+tCACKxSZDrOGFBwvjX/XhPjEXVLHijxhK8nvikgeZYvcapGuoE7PtUpNnwPLzoj2Lm9flXytm31eUmpFaQBlvJxO8m13SKR2WEGDMgFovjSBY+H8X5Aancs6w5oHlb1PLxrkjeioPUXK2vIOuqEJMNMoLHHCW9YzZkxyIgrn0sJJNB9dIc4x0JRsTlmGwLHNXppftHr7hXgAPKMwO5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibpTY6FQxW6Oyu1ULswjt0jdtrTxepj4AFfhX/WnMAA=;
 b=RXeFHox+QzlGkBBtAoQj5JXUwiF/gxO32MiSMth+vODtu99he49FVSptj1P9aD8/CH9iZoSWZLbcl2aK9Y+88fLNJaJj1Ys8DwJmQHCTxm0VUBwS58P9NHlNL5EBSn/ZluL62uoaMa/0TWKh+EgAhI0lGSt/kkJqy5YSznqPuGixQFJSIyEWRW0nyLJzm9pndCj0yMec9mDOEhawQyeQwyj/8PDAQ7tSijjkiABivcSfgWnsqGpzMReju4A07de7HIeL+mVH2r+dOXefLps3TPDvif/1tC70zyd+zoElNr9+VAsWeFYewm0N0Wmk/O3gzIyKH+P8+1MInv7hV7vaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibpTY6FQxW6Oyu1ULswjt0jdtrTxepj4AFfhX/WnMAA=;
 b=OqT5KGpnQLaaDINl5VFqhXDp8mJgq0hHs+TXv8/Skh5/E3NREdtkNQLXWEq4TJ2Vxk83+ZHms5jTonIH3rzGa2BE3boZcjm/dBDn0Z86H11iKkin7NlTUOEw6ZJx0HoDtWtcY6rxPCtws2/oQLU8ya/wOjtDtxecfsZKCc37LI0=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM (2603:1096:820:56::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.12; Fri, 2 Jun 2023 12:22:09 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6477.012; Fri, 2 Jun 2023
 12:22:09 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Index: AQHZhBiUq424crV8z0Sj0fJkb54l069oNpQAgAF1oECAAB95AIAAz9nAgAB9mgCADHVq8A==
Date:   Fri, 2 Jun 2023 12:22:08 +0000
Message-ID: <PUZP153MB07490EDED3B0194F5518B26EBE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
 <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
 <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <13922610-b9bc-ab4b-8482-9aae238396c7@intel.com>
In-Reply-To: <13922610-b9bc-ab4b-8482-9aae238396c7@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64c02fb1-2010-460c-a202-44f2180fe28a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-02T12:11:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|KL1P15301MB0450:EE_
x-ms-office365-filtering-correlation-id: 8bda245f-4377-4cf7-5c90-08db6363fc65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMPrJEJAIE+URLzMXgNKFM+XkP/Ar10td8hM83H2OKi82h4k5/NeQtpD996eCLw2OCgx10MnpByITd3LTYlwgM6ossD362EsowRPs7AVRJbe8qC0Qcdb7z2VjZ+vRKPTIcb+Z3QkBqPs95/JX8LFHKlHrs9jEOtNdFPvHzKT3XQdLL/PbeuK2suLtO9Rlz3cv68FztSn0UxfefisSR9Yr59j5f+1cdt1rQa5EGryVN8/TBsEQIz+WWnK3GR9EZk12dXqSgtYeD4gio/lk/N8ExEyrfH99h8uoS3sbZ496syzRRJHHeGUaQHisGy/K1qd9b/lg8saKrSHzsbb2Q21aQMk7agUdFhXCxbi57fpQ1XRP7gKkRl/el7AaEpgGSZfjF1cTMIPNWw9LiR19EmXL0wc94NVd7UjvM0eUNnlKy23KMJOYXn8mX/zc2/mRSI8R3WldSzUzrK+87FCUwDYI+c3VwohkImv4Qje45R0CtXDp3zjOPzJiNHCkZ617a611wrvx5xznk6YThSiMRNeT6mgpXEmy2UWWj52Hw7VRTcAH/twRSbszzlOyHhwd2F8lO9UuxE4bw58BY2VoQeXT6qoXSj81M2ULOA6iPSBsA3c988JS708In13u77YkDWLRisRJqG00vaKFrP7X9KTJUct4bmBroCavLfDO4teFW95n16VON78xMbfWMbjpj8a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(55016003)(83380400001)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(6506007)(9686003)(71200400001)(7696005)(53546011)(478600001)(10290500003)(110136005)(186003)(86362001)(7416002)(2906002)(52536014)(5660300002)(8676002)(8936002)(33656002)(8990500004)(41300700001)(122000001)(921005)(82960400001)(82950400001)(38070700005)(38100700002)(316002)(786003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M295dDBsTGUwOUwvNCt4MFhOajJ0eTVTZS9QbitSQ1ZlZUR3Y2J3Z2Jkb083?=
 =?utf-8?B?cWcvWVN2QzYycXVoQy9mWmFDcmFzV1N3MVcxUVlya3FoNUxncVZ4SGFETVZX?=
 =?utf-8?B?TklQODFKOU5jeGlPaS91c3gvdGJPS0RwanFmcGdCMFNvek5La0RIakZiRkQz?=
 =?utf-8?B?M1hEdGZFNXJrejg0Q1g4WkJ3TW4wQ0tXdjRQNjV3UXVSaHN1VXFxK2pCZndG?=
 =?utf-8?B?TER3V243ek5UU1RTSi8yOFNzWUU2c1h2cGw0eHJ6cG1TOFllV1diRTZzb3JB?=
 =?utf-8?B?UTFKZTF6eDdlT2V3OE1sUC8vUGNGYVdmZjlFVGhDai9aeEJERHpObVh5c3RP?=
 =?utf-8?B?MkxPc3FPcmloTDlPaVhPcU9GTEpSTFd5N0xHUEZRVUh5emQ5N2FYWU1zaVI1?=
 =?utf-8?B?a2VtUVk4bi9rR2RqZTNiRlVkWjRHOEE0ZGU0TTZXTVBZeVZrWnhZdk0xMWN4?=
 =?utf-8?B?NTFxam5mbkFVSDZhd1BFMk8yUmc2bVpyTFZzK1p0clBUZjJ5QVFSTitVMVht?=
 =?utf-8?B?VWhIZWY2Q01VMUdPck9JWHUrOHU2dDEydTBQSTRMR3ZwU0svL2xUeHBETVRy?=
 =?utf-8?B?ckpDVHlDZ0dvMGo4RWUrN1ZIYm0yNlVZR25EUHJMOVU3OURjWjZNSXFlL29S?=
 =?utf-8?B?WWJXUFllOWtLT3J5enpOajVaMGtCaWtURUJTUFRqZDQzZisyUG8raUNlN1hK?=
 =?utf-8?B?aFVyc2p3Znc5dHo2Wm8vbGdlOTZZMmFxd21qU0ZxNkJ3ZTh3dERsNzFhNlJO?=
 =?utf-8?B?UmF3L0dwZnJTOWd3YTRqLzNLRmdBNS9BUFYrbTFiY0swOTk1Nmk5ZEU3N21U?=
 =?utf-8?B?THZ6RUFla0g1ZGV3Zzh5UlJab3p1NmtXT3lFbWhsNkZ5RFR3dnJlb2R2TjNB?=
 =?utf-8?B?b3FGWm5QbXBtajU5blFuVkRNcmVXNVVBbmwwSG9BSFFvZ25XR2JldVR4T3FZ?=
 =?utf-8?B?NTlNRFFEREUyTFNRTkFFWlRkSkxTNy9ScDlpQUl2dzRNLzRPL0VnRUhYUUtn?=
 =?utf-8?B?Mm9Hd2VzMlpoT0VER3JESG9xZVJVTXhsNkwrdFU2MDhOMGVlRG56Q3p5a3Rh?=
 =?utf-8?B?R2dsbTBvZzFZTnc4N2VkbWl3L2R6OUEyQ0dCZTcyc2tqaTIxTUhNZitQRE1S?=
 =?utf-8?B?VXhPTDc1SDVTQmdORXR0TlFKMWtUSkVuZ2pJSmZ4MDRGa1pyK21ya09zZGI3?=
 =?utf-8?B?UDBzUmtqTTBvZ2kwMWo5R3ROM3ByWi84T0hqeHU4RW95WHZaOWZLWVdoZUZp?=
 =?utf-8?B?N1UyL25rMlc5eXlzSDZVaHQxL0xaY3FYV251U0REeFJwYmtMbkgyN1k4L3dE?=
 =?utf-8?B?R2NtaWl3Tnd0MFN4REdteFZIbTdRbmJ2QjFhNlZDUFlNREZhY1UxRHBpbXRa?=
 =?utf-8?B?NDUwUDFoQnVocDhyLzFNQzBvQU5TbVJvTDNNWU44Vi9tcTdJMFFQZ29qMGJP?=
 =?utf-8?B?dXlUNkdDWEY0SUdkQlcyN01mTWxpQlF2a0JTdlFyeGV3YnB6a3A0TGRCN1VX?=
 =?utf-8?B?S1VYc2N4SXhISDQ1ajRCbnUyS0xoN1JkR2llWFJRSGUrNW1NeU43dTF3WWtQ?=
 =?utf-8?B?OXBUVUFTYUhLNnRBbTBhWlZUaG1qUDZReGZ6TE90cEFuWmJrVmtTQVpkWlhq?=
 =?utf-8?B?NnBWL3BvM1V0S0VscDZMRHhXMytxeTZkbmFlcExHaU5mbmtSNmpvaWJ4SmU2?=
 =?utf-8?B?dTZ4TkFUOWVjbElxMTZ2VFI2MjJlR2VZeHFTUnM4VEt0S05NWTNOMzFEc0Jk?=
 =?utf-8?B?cThXSUhyM0hrWHNHVHpTRXFpU0lkSktXV0UvanJDb3Z3Z01OZWNjZ3BzSTEw?=
 =?utf-8?B?a21scVdwd04yVXE5ZEdXWmJiTjBqZXlTMFBHYkFIRVoxNExrSldhTm5GcjFy?=
 =?utf-8?B?dFpzemRNaEpJenBVS3JyK1VkVTBYSUlLdFJ4NTVHYkRZRDgxcFhjeDNsUFBG?=
 =?utf-8?B?VWE3WktJTFZEdGwwb01xdzNKdkVBRWlWejZLN1o4LytlL3JyVWIyYWtENWZt?=
 =?utf-8?B?eldVOG1BcE1zMWV6Z1FNQW12RHVWT1BMeVlWaTJDVTYrUDlrc1g0eUFYLzl6?=
 =?utf-8?B?aktFRlNpbldpZTlOcEl3K0QxMUVRZFhtdC9vdkRNL3YvZkhmaWVXUmNHbWZr?=
 =?utf-8?Q?NCNnuciJEVOvaCDEKSLSykKoC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda245f-4377-4cf7-5c90-08db6363fc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 12:22:08.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwJAy/1w9iakhNh0s9vMXnHRy7BlWY9vWUOl1wy+MKuMyEw0faaJPdJ/mkftZKKCrOsvsVk2fSdKOQKmmqggdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0450
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyNSwgMjAyMyA3OjI2
IFBNDQo+IFRvOiBTYXVyYWJoIFNpbmdoIFNlbmdhciA8c3NlbmdhckBtaWNyb3NvZnQuY29tPjsg
U2F1cmFiaCBTZW5nYXINCj4gPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT47IHRnbHhAbGlu
dXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsNCj4gYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNl
bkBsaW51eC5pbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBLWSBT
cmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6
QG1pY3Jvc29mdC5jb20+OyB3ZWkubGl1QGtlcm5lbC5vcmc7IERleHVhbiBDdWkNCj4gPGRlY3Vp
QG1pY3Jvc29mdC5jb20+OyBNaWNoYWVsIEtlbGxleSAoTElOVVgpIDxtaWtlbGxleUBtaWNyb3Nv
ZnQuY29tPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaHlwZXJ2QHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIIDEvMl0g
eDg2L0tjb25maWc6IEFsbG93DQo+IENPTkZJR19YODZfTVBQQVJTRSBkaXNhYmxlIGZvciBPRiBw
bGF0Zm9ybXMNCj4gDQo+IE9uIDUvMjUvMjMgMDA6MDYsIFNhdXJhYmggU2luZ2ggU2VuZ2FyIHdy
b3RlOg0KPiA+IFdoZW4gQ09ORklHX1g4Nl9NUFBBUlNFIGlzIGVuYWJsZWQsIHRoZSBrZXJuZWwg
d2lsbCBzY2FuIGxvdyBtZW1vcnksDQo+ID4gbG9va2luZyBmb3IgTVAgdGFibGVzLiBJbiBIeXBl
ci1WIFZCUyBzZXR1cCwgbG93ZXIgbWVtb3J5IGlzIGFzc2lnbmVkIHRvDQo+IFZUTDAuDQo+ID4g
VGhpcyBsb3dlciBtZW1vcnkgbWF5IGNvbnRhaW4gdGhlIGFjdHVhbCBNUFBBUlNFIHRhYmxlIGZv
ciBWVEwwLCB3aGljaA0KPiA+IGNhbiBjb25mdXNlIHRoZSBWVEx4IGtlcm5lbCBhbmQgY2F1c2Ug
aXNzdWVzLiAoeCA+IDApDQo+IA0KPiBUaGlzIHN0aWxsIGp1c3Qgc2VlbXMgd3JvbmcuDQo+IA0K
PiBJZiBhbiBhY3Rpb24gY3Jhc2hlcyB0aGUga2VybmVsIGJlY2F1c2Ugb2YgY2hhbmdlcywgd2Ug
ZG9uJ3QganVzdCBjb21waWxlIGl0DQo+IG91dCBhbmQgbW92ZSBvbi4gIFdlIGFkZCBlbnVtZXJh
dGlvbiBmb3IgdGhlIG5ldyBmZWF0dXJlIHRoYXQncyBjYXVzaW5nIGl0DQo+IGFuZCB0dXJuIG9m
ZiB0aGUgYWN0aW9uIGF0IHJ1bnRpbWUuDQo+IA0KDQpUaGFua3MsIEkgZ3JlYXRseSBhcHByZWNp
YXRlIHlvdXIgc3VnZ2VzdGlvbiBhbmQgd2FudGVkIHRvIGxldCB5b3Uga25vdyB0aGF0DQpJIGFt
IGFjdGl2ZWx5IHdvcmtpbmcgb24gdXBzdHJlYW1pbmcgdGhlIG5ldyBmaXggZm9yIHRoZSBWVEwg
ZHJpdmVyIHRvIGJ5cGFzcw0KdGhlIG5lZWQgZm9yIHRoZSBNUCB0YWJsZSBzY2FuLg0KDQpGdXJ0
aGVybW9yZSwgSSB3b3VsZCBsaWtlIHRvIGxlYXJuIGFib3V0IHRoZSByYXRpb25hbGUgYmVoaW5k
IGRpc2FsbG93aW5nIHRoZQ0KZGlzYWJsZW1lbnQgb2YgQ09ORklHX1g4Nl9NUFBBUlNFIHdoZW4g
TVAgdGFibGVzIGFyZSBub3QgaW4gdXNlLiBDb25zaWRlcmluZw0KdGhhdCB3ZSBjb21waWxlIG91
dCB0aGUgZmVhdHVyZXMgd2UgZG9uJ3Qgc3VwcG9ydCwgd291bGRuJ3QgaXQgYmUgYWNjZXB0YWJs
ZSB0bw0KYWxsb3cgdXNlcnMgdG8gY3VzdG9taXplIHRoZWlyIGNvbmZpZ3VyYXRpb25zIGluIHRo
aXMgbWFubmVyPyBBbGxvd2luZyB0aGUNCmRpc2FibGVtZW50IG9mIENPTkZJR19YODZfTVBQQVJT
RSB3b3VsZCBwcm92aWRlIGdyZWF0ZXIgZmxleGliaWxpdHkgYW5kDQplZmZpY2llbmN5IGZvciB0
aG9zZSB3aG8gZG8gbm90IHV0aWxpemUgTVAgdGFibGVzLg0KDQo=
