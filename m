Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04560634224
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Nov 2022 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiKVREI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Nov 2022 12:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKVREH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Nov 2022 12:04:07 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021017.outbound.protection.outlook.com [40.93.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8278185
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Nov 2022 09:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtmNdq6LHdHSuW5Ae//KNUJKyBxVlCzcMcd0XyYTsb0KqbAxve8NNQu/lsr39n6JALVpV45BU0Jv0NeEJu9gijEqlqW06EQfugrnN6KdrRMqvoVwFjTu9yOTFqCv1Y7KBiCXVElqLAUJWl6pBAGMfLiVQOSCqlH4bqTBfgyrzvhO4hCLoSbvI2pUc1Ak/he8oBMCTMA1G44YI4cSbHtJPSP0wjWKH2VP6L9Wd6J6OR27QlR/EzHmfdFRwKqwxoEJRbQuXZ2uNtLui0brcXD1mYazNvK11STkUec5A97xYMBVWQm//su/HjT717CsvNRrDBFEQh35oLcO5nS1f3UjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBhhiDJ9OP6IAeiwV87qQPyL2FXUKIDuKLv+6ZkOaQ8=;
 b=SjE8pO2pxLdtajrkeds6xyueT9xbSshYmfjlWhZ5BZJDnDD55TxKHcJ8h0LQ+ld6D6g0pxSotndXfCWiD17oIlvcGpeMwGQABMJS2KGcDPCkZnDqOG+++J5moENn6t9tAF3tBBI0BMqjy4Nu43Gvk1tFAdSc0CZAniBHRqTKvSKnEEFoQVxgq2CayTDiSP8IukweKFk86kp+LMTp9GR/mQD/0to/kJ2sngWs+A5mliEqk7UJir+eQYIRYd4bS1rurxEckEQ5NOnB3m2hlxM13xGs3PGTguosdQpxvgtC8xsc2aNggd4UTPj7SU2tbScxmIBHXCezrR+u+z8S8Kq5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBhhiDJ9OP6IAeiwV87qQPyL2FXUKIDuKLv+6ZkOaQ8=;
 b=fOk4uVHurOyiUJB316Jo9N+QdNN18eq/vAcXF4tHT2zVSOQQqfBPRJ2BzytmyjPzwlp36nEjkSvm/rdYR7AaTbV0thxQ363A4epo5ooeCNEb56tN17IKf0L9FPLYn6fp2gJKvDvixsdbl8JZfCM17t0YXIpPTs4uLSojk7nriuo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1911.namprd21.prod.outlook.com (2603:10b6:510:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.1; Tue, 22 Nov
 2022 17:04:03 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.002; Tue, 22 Nov 2022
 17:04:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Nir Levy <bhr166@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>
Subject: RE: [PATCH] drivers: hv: vmbus: Fix possible memory leak when
 device_register() failed
Thread-Topic: [PATCH] drivers: hv: vmbus: Fix possible memory leak when
 device_register() failed
Thread-Index: AQHY/gfY9+p0ZM/V1ECykNh+8lgP0K5K2BUAgABTOeA=
Date:   Tue, 22 Nov 2022 17:04:03 +0000
Message-ID: <BYAPR21MB16889DB6CC41073D1AFCB5F5D70D9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221122001724.218299-1-bhr166@gmail.com>
 <f5adc72d-a215-fb25-a8ed-f44f29eebf2b@linux.microsoft.com>
In-Reply-To: <f5adc72d-a215-fb25-a8ed-f44f29eebf2b@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fc5e52b-8e6a-42d0-9909-84ff77b2b703;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-22T16:58:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1911:EE_
x-ms-office365-filtering-correlation-id: 79465cbc-ab67-44db-b428-08daccab8f12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1K9Q/InjI9eYWHVVv3kIYWJJRJeKuOJ5y/49S6JV1Fp5qd00Ryw4wBmpD1w1k2/w+jZcFPRZRcbCbriVM7VD2JsbitRafHMYbCNGnT4VQUh78CSIHRr6MYUdXZHBEXMA5tXTmgYYqN/GmssajHA2lGUQk96hxmK9d7Qd/Zkngtg0a4I3tOTYAqSW7XiqSF/uq22hk6dC2TwVZb13GSs2cr71Iw7/osMgW+Ns6E//qTCSTz2DknSRe8SQd+fBgECjnL72PTAMNgFfKODxiPhgO9ZmDNzK5nGo5A7Z4coFl1Hvss/Lm2zR8OCSFPZ0hLTcUJ0PHAoZ1VSbUSCi+x9xItnFO6mKtCFqzjwp/ad1Ts4FhJGuhYtSnxM2143Smc1Z67xMuBnkoapvTSn4qb7IjLouT1VlfZpRrh3QYCY8JbrAqmEHyPNIcEpJE/3lr4CGtAXYpHZB8UtHkz8WSlH69kHXaMrIztHpaOYEb6i3jeZbAcdx2yxGLSFEGMLBIe4S5Ia32oPTzVqdQuX+y/PNMkOUCeHmnSmEgwahSj2PdVdL2h2QfRF180M4PErvb3l8D7L/u6jMaBVthYh/NugftO+miijWrdWpo/3gIzcyA7X+jOuUr0llPItOEUL1Q8yV2r0N07qIvhSyO4GmSQIkhgrozBTxI47eQmoZ6m5laYuxNjAjLfnY7dVBN1oAC3JxvgYOfuhvlXHIJEJBPVv6ZjT3joozbZ4MI0IcEJGhPHCg3kqgVi9mKvSmHb6U7qxvhV9n+0jQRddhK9vYhoprirjW1p9i8X+tuis7zPDgJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(10290500003)(2906002)(86362001)(8990500004)(478600001)(71200400001)(966005)(9686003)(66476007)(66446008)(76116006)(53546011)(66556008)(66946007)(64756008)(26005)(33656002)(110136005)(186003)(52536014)(6506007)(7696005)(316002)(6636002)(5660300002)(55016003)(83380400001)(82960400001)(82950400001)(38100700002)(38070700005)(8676002)(8936002)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTV6dXptWG1XQ2tZS01Yd05SajkvZStvY0xFb3lPTjZzZWtCc0hLM2JFRkIy?=
 =?utf-8?B?WVUrMXF2T0V4MEkzV1FtbU1yWENaZkdVWFdxVm9lWlZuRmYzTC9XSkNVck5a?=
 =?utf-8?B?OVhNa3Iyd2R1QW1vMWduMTRoN1o3ZTEza2dTKzRpR3dCYU9XSnlOUG80L3Iv?=
 =?utf-8?B?VlpwS3BMNDQxVWtwSEdNeGlVWTl2RnM2VzVPZmNGYXJmeUt6Z3hRSEhkY0F1?=
 =?utf-8?B?U3lJSW9zUWthaW44bmF0eTZVQzRwLzEvTFBXbDRIYS9XV0FqbHpKRVhReUlN?=
 =?utf-8?B?RmZLOWQ3c2tHdnhKV2V6c2xpbWlieTlJMW5oNm5XM29DZDBqU0NNSk1TUFht?=
 =?utf-8?B?T0JjZi9Ob0g5clMyOVRKK0l3M1QwdklocHpaN3RlT3VuUjRJTDFHYVQ4czFy?=
 =?utf-8?B?dTU1eDVQYWhUbmE4V3NrSHJIRzRxVUhpcVg3Y0xFRTYwOXJ2SE1nbERvTTNB?=
 =?utf-8?B?R29iN2tpVHFvVFNQMzZaYVdyb1FSZWFmQ2JXZXU1ZFpvSU5tU0tGdUlRSFg0?=
 =?utf-8?B?ZHBScllQZFljS29GcTRqU0dGMUhsaHI3SFJWM2FjdWdwWGdWMG13cCtpemtV?=
 =?utf-8?B?cTQ1YTl5cndtWStpaUl4aTlGbEpEVlpnWmFMbEw0ZXU1c0NGVW9saHVXVkVD?=
 =?utf-8?B?bWlIT2ZGN1RyNkdHeEZ0MS9vWnY3ZlNLVVVmSXU4NHltcUpSc1JCVUZJbURv?=
 =?utf-8?B?V3l5NnNuMTlzUXBwV0cwNjBkRFpKVlE4Y3RuNzV1cUxGbUpHbEt2NjErbmRs?=
 =?utf-8?B?MlhYY0haRWJHSkVuN3pkOGltRXVQRy9INFFaczdja0owNGdrdDB6TDdxQU9y?=
 =?utf-8?B?YzJnSDR0SW81WmNaYWFBd2ppdTZ3WHhlZW91dzJ6UGQ2czFwVVIzYi9IeTlq?=
 =?utf-8?B?aC9NSU9rRDNEaEMxNG9QRWJmK2swMStLVXJtVWtIeW5Pc1lsNUFUSGp4UUNQ?=
 =?utf-8?B?VUVyUWFkczFCRFZjL2xTYWw5ck9Qd3dtTHMzTk82NWljMU5Rb3o5MURkV3F5?=
 =?utf-8?B?Z0xKbHJva2ZxdlM2YW5LQ1paam5JVXdWZFcrQnk4bzJiQlZFeEZoazRlb3pU?=
 =?utf-8?B?TTcyL0J0dHQyaVN5T29PZEpqaTBxMy9rRFBncjVuOFgrTXFvZmQwUUJNay9s?=
 =?utf-8?B?ZEp3N0gzMlo2WVIvaTFkOWJBdnZ6aEdwSFZuc3BHNG9PQkp5NFRMTjZmQitu?=
 =?utf-8?B?NEcvWm9FREt5c3NjTUJqelptbnhObGxCRkN6WU1VSEgzUHlQMnlwZkd0NytV?=
 =?utf-8?B?RVQ5bWVHaFRpQ3pzMEplbXZLeUxTVGJPVTM0TjV2c0tDTEtlWVU0T3V5SjN5?=
 =?utf-8?B?U2pkN0FpbnZnUU1PQ1NsSS8rM3pXcm9ORVhXWllHTDRHNjFYdFRrMXlucWRZ?=
 =?utf-8?B?cXZUVk5ncU5ta3ZqVllvenZ2ZU16TGdjY1d4S0NVWEJYb2h3Rm1RMmhoWTNI?=
 =?utf-8?B?bG9JaDE3Z2NWVHVJM1dRL3Z2YVpRRmRHbnduNU9ZMkNBcnNwOFZGSWp5YmFV?=
 =?utf-8?B?RVhLSWpNS2xwOU1UR3UrMy9FNnIyemhUTmx5MHhFalB6RlhDVXZIQVdHSkJh?=
 =?utf-8?B?VWdUKzY1Q3B6dWpRTW1NZ0psY2FPSHZ0c2hycW1saXF3TFdrYnlURjBtRXEr?=
 =?utf-8?B?LzRLMkdGQjNleGhNbGpKWUNuZmMzR1NHeUJERU5aNVQvY3hiRTVmNDJCRThj?=
 =?utf-8?B?Q2MxZUdZS2phT2t2VzArOXdJekc1MWIxVTkra24rc0Viei91TEZObjQzRmxE?=
 =?utf-8?B?Ny9wNG9HR2piaVVZTG91ODJ3K256WU5pZk9ybXN0enlROUtHaStpbWVsK1E3?=
 =?utf-8?B?SnVyLysxdDBHbmRBa2RqVG56S1l3bXVKdjI3YXZ4SGZpd0lrM2N1eXYzeU42?=
 =?utf-8?B?YncvZm9RSGNyTFQ2aUZoR3dCRDYvUzZCWXdPaElPR3NqQ3JybjhkQnA5Q3FN?=
 =?utf-8?B?c0ZUcUlHTFB4b3F3M2llemh3NUZXOEdKOXFSQ0Z3SDhYMDhzZnJYVy8rOGtL?=
 =?utf-8?B?REJWRThPTUVYRkx2R3drOXZ3TlNYMmJtdnJwR0JQMHIzWGxTTUpRWnpYNzRK?=
 =?utf-8?B?ZnYvUnJBUHBDc0xycVlLVTJ5ZDF6TzRVL0hSaGhJK3REczdwMDJqTVZ3Z3l6?=
 =?utf-8?B?NE1zSndNakdTWmtDaUhpQjBnQnhaTTFlakdiVlFyQVpqbHY2bXliM3c1UHpn?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79465cbc-ab67-44db-b428-08daccab8f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 17:04:03.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSSY1F6sITMI19wmYclAF8ShcaDS0lG4CKgG772UeW+8DnDCz8i3Ne02Sbl6fXckaWuDFZIK6rJWNrmD9/Hlt74dGVPuvo9nSZ7J2r95heo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUHJhdmVlbiBLdW1hciA8a3VtYXJwcmF2ZWVuQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNl
bnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIyLCAyMDIyIDQ6MDEgQU0NCj4gDQo+IE9uIDExLzIyLzIw
MjIgNTo0NyBBTSwgTmlyIExldnkgd3JvdGU6DQo+ID4gVGhlIHJlZmVyZW5jZSBtdXN0IGJlIHJl
bGVhc2VkIHdoZW4gZGV2aWNlX3JlZ2lzdGVyKCZjaGlsZF9kZXZpY2Vfb2JqLT5kZXZpY2UpDQo+
IGZhaWxlZC4NCj4gPiBGaXggdGhpcyBieSBhZGRpbmcgJ3B1dF9kZXZpY2UoKScgaW4gdGhlIGVy
cm9yIGhhbmRsaW5nIHBhdGguDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaHYvdm1idXNfZHJ2LmMg
fCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYuYyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMN
Cj4gPiBpbmRleCA4YjJlNDEzYmYxOWMuLmU1OTJjNDgxZjdhZSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0K
PiA+IEBAIC0yMDgyLDYgKzIwODIsNyBAQCBpbnQgdm1idXNfZGV2aWNlX3JlZ2lzdGVyKHN0cnVj
dCBodl9kZXZpY2UNCj4gKmNoaWxkX2RldmljZV9vYmopDQo+ID4gIAlyZXQgPSBkZXZpY2VfcmVn
aXN0ZXIoJmNoaWxkX2RldmljZV9vYmotPmRldmljZSk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4g
IAkJcHJfZXJyKCJVbmFibGUgdG8gcmVnaXN0ZXIgY2hpbGQgZGV2aWNlXG4iKTsNCj4gPiArCQlw
dXRfZGV2aWNlKCZjaGlsZF9kZXZpY2Vfb2JqLT5kZXZpY2UpOw0KPiANCj4gSSB0aGluayB0aGlz
IHBhdGNoIGlzIG5vdCByZXF1aXJlZCwgYXMgZGV2aWNlX2FkZCAoZGV2aWNlX3JlZ2lzdGVyLT5k
ZXZpY2VfYWRkKSB3aWxsDQo+IHB1dF9kZXZpY2UgZm9yIGFueSBmYWlsdXJlIHdpdGhpbi4NCj4g
UGxlYXNlIGRvIHNoYXJlIHRoZSBzcGVjaWZpYyBmbG93IHdoaWNoIHlvdSB0aGluayBtaWdodCBu
ZWVkIHRoaXMgZml4LiBUaGFua3MuDQo+IA0KDQpUaGUgcHV0X2RldmljZSgpIGRvbmUgaW4gdGhl
IGV4aXQgcGF0aHMgZm9yIGRldmljZV9hZGQoKSBwYWlycyB3aXRoIHRoZQ0KZ2V0X2RldmljZSgp
IGRvbmUgYXQgdGhlIHZlcnkgYmVnaW5uaW5nIG9mIGRldmljZV9hZGQoKS4gICBUaGUgcHV0X2Rl
dmljZSgpDQpwcm9wb3NlZCBieSB0aGlzIHBhdGNoICppcyogbmVlZGVkIHRvIHByb3Blcmx5IGNs
ZWFuIHVwLg0KDQpCdXQgc29tZW9uZSBlbHNlIChZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFu
Z0BodWF3ZWkuY29tPikgaGFzIGFscmVhZHkNCnN1Ym1pdHRlZCBhIHBhdGNoIHRvIGFkZCB0aGUg
cHV0X2RldmljZSgpLiAgIEl0J3MgY3VycmVudGx5IGluIHRoZSBoeXBlcnYtZml4ZXMNCnRyZWUg
d2FpdGluZyB0byBtZXJnZSB3aXRoIExpbnVzJyB0cmVlLiAgU2VlIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2h5cGVydi9saW51eC5naXQvY29tbWl0Lz9o
PWh5cGVydi1maXhlcyZpZD0yNWM5NGIwNTE1OTJjMDEwYWJlOTJjODViMDQ4NWYxZmFlZGM4M2Yz
Lg0KDQpNaWNoYWVsDQo=
