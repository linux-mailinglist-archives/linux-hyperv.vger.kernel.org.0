Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDC616EF9
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKBUoQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiKBUoP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 16:44:15 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022026.outbound.protection.outlook.com [40.93.200.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FB6444;
        Wed,  2 Nov 2022 13:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddPdhudpyj4YkYn1WUeg6hJEzqyUcfl+09+KlHfygF4JjpQ9z0KQX/cD1ezpijsA0ecFB/e/UVpZH8ho5Zw0GxpkhBcQknFQ2ES5NEVDS4oYT+cphVl7N9fqkxddDgaUent79ISJGrBC2AgHG/WmDQy+InZvOsxTWT1vz0qCBGb5fToGlPZ3NWwXai4231eaJ6mufLkzgxE5mur2KzlZeNAeQ108Qkk1e5f1rITzguJeaF2Tu62LgE+ZDX/syRiSUg24HKKP6QBk5XQs2p0zzkioX7GN/McDpYpmrdKGDKbS8gpRtgi7LvigjLAxogpcLSa7p7pu6sxq+Kygv1AGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UNH8txUvuLCHnb+ixRn9rGLeEWG5bApwXgAChEsH04=;
 b=g/ahvAFgVh1iYTbENTRFSibrm2VFM78mQEvbvOsD15Sk/+v2OWr12zeLxHSUMQLVXy9bTrnCYYY1w+eROAdzT4flhp8fg6mUnC4T91eWG9PyGm5ORQf3IJyYNji9yQpfYDrHtbB1105WGuXMchueaZTcCLex0piZAiUsZFFmpYogwOLsvkLXjbYeADcEZnfBjeVTsnzSmo1K2n8bIJXoGCq+GKvm3tfPAEtPQMzuCHdghCJ1mGW2RV5o1ycQIDWy7mhtpDu14csEWmBl9C+BC05t9WQJlbkfIkwA4tfcvnfE/dlSVwe5wzsceDDtXJIlX+JTBNwpZ/uQfif3Kqi3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UNH8txUvuLCHnb+ixRn9rGLeEWG5bApwXgAChEsH04=;
 b=NunWiLv4Ksdf3yMYvJzyNeVMTlzPzsemZSAv2EBrIIVm95DcR1/BkqVtIsdDE+VYKQKHlzTBaPmU42xv5JfzZl6AANRWjd+feKBT8S7hky2sfOomPP2PSRoPxEfjNhMAv68XiMW3VcpLYgv7NtwAIv9EnQF7jD41MhfuaYvr93k=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1917.namprd21.prod.outlook.com (2603:10b6:a03:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 20:44:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 20:44:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
CC:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] drivers/clocksource/hyper-v: Introduce a pointer to
 TSC page
Thread-Topic: [PATCH 1/4] drivers/clocksource/hyper-v: Introduce a pointer to
 TSC page
Thread-Index: AQHY7he/duewECSvK0C3ncRhEYtCRa4r9x8AgAAMlACAABUZ0A==
Date:   Wed, 2 Nov 2022 20:44:12 +0000
Message-ID: <BYAPR21MB16887D9653B419A14CC29511D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386464.9827.16622091938453285710.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB168821E469CDBC3E6BD171F0D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLxD8X3cjFNAXYjxr-1opJG_uzU-Ajvz_poMccaiANtQ3g@mail.gmail.com>
In-Reply-To: <CA+DrgLxD8X3cjFNAXYjxr-1opJG_uzU-Ajvz_poMccaiANtQ3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6486d5d-21f6-48e1-8228-16ae62af81ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T20:34:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1917:EE_
x-ms-office365-filtering-correlation-id: 7c3d524d-e0bc-43d2-d07a-08dabd12ffcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 96EUyM//nW5+YBI4TAHXMVJylreBW1xNizGxJrvXAf5XyC/PNknPcnEKBE8KsY6GKNwe+OQVintdRg//WaEnhD5bUIA5KQ1eJrkZu++83TNIcQ22hsaUgD6Kt5jX/dOWHuo1WEv8tYpzHRcEMRH7MafbDKOgEjHffiZsVmW9huCFPGWlRGweAS/47vlQZjJr6kAyk1Y7D9cPu9K6LgVmh6q6P8omtBtj6H+y6NU/0Qo8xxdblaZB0Ckdd3m1DBT0sKEfp3K4fjRQPtgn741MkpK5mLggXfFHD44s7jbVFXPQRMqM8VDRBNZTq4pp7jrAHxbKrMS3OKywIuERlFQvl2CrdXNL6DOY+S22o5Dvwy1Bx+ggEwCxZ8hmBOVhnMEkjZQk7jBQBN4ES5LnANEBx1LRrv8ksAMd8GfS9bUvFwQOCc4o3JBouIemBsCZSK3jYplFB98iHQl7HGN2LTdwPGcryh6wylj9sawR6D/NrX0mEy86c7A6R0awkm1lQ25WGFZgwja/RkrzF6EYaxX0XjlkUaHxPkXvmcg1Q3lmzKJ7deJ2HXMolgPCmn7fS7orDWNcafa6HOxo124h6L3d4MOUvz9cA7mGfujxXr28X4A8jssoIncS4nakHMZUFk3UPZ8K+VDhjSFXTJ75iJgHKLRj84XvnVwzgHfyejEUiKXW7Ues+vX6nTC59uRSF/cet0XYMU8DbODjMLkx3O7hZQB/EQKqYPnHuz0FBcPeWjPqrtl8E7/7t81gT4hF5WlWfeV2A3Z+Fcfh6pRosMMPU5SU85q7HOxU7zmjCKa8rDm+PHToHJHWDysv84AJDrrP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(8990500004)(122000001)(38100700002)(2906002)(82950400001)(82960400001)(86362001)(33656002)(38070700005)(71200400001)(5660300002)(6916009)(76116006)(55016003)(8936002)(478600001)(66556008)(4326008)(66476007)(66446008)(8676002)(83380400001)(66946007)(52536014)(64756008)(41300700001)(10290500003)(316002)(26005)(6506007)(54906003)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS91d3VLWHdCVDhMdUtMZEZoTlVVTzcwVnUvb1RscUZvRFJKUDJPYVgwNXB2?=
 =?utf-8?B?OHlWTlJ5UktLaENqejJZa0FDbUtKdE1vVGVyV0wvejdpSTNRakNQTnRML2dZ?=
 =?utf-8?B?R0JWMXFHN0lHT3pqQ3JTTDI5RWFTbHhjdzh3QXQ0TzhCZ1hMTHlWdkdBMGRQ?=
 =?utf-8?B?YmlYVGlBTlhra1UwKzN3ZUg3bjJWeHRWZDVLY0RSOXo3L2RIOTIyWnhPWW9Q?=
 =?utf-8?B?Y05HNkllMklGMFhUN2dvRXpFRm5kSC8wN1IrY1FCSHIraXRtL093R2VrK0tD?=
 =?utf-8?B?NGFaRldwNzlTbnNCdzNPZFBYSGhBMC9nYWpNU2FJblUrZVdEMno4bUJUbDdT?=
 =?utf-8?B?d2pHZzl6eWxLRElqYW5uT1Z3VGhUcGIyRkE4K3YxTVo4RWJqaytLejFPait5?=
 =?utf-8?B?enRQOSs1V2pEejl3SEdFWVIwWVlnMll1Y3RCWWorSEtkaEU3WWxCYmxQbDM3?=
 =?utf-8?B?UHJnNEM0b0ZCeENLYkpkY2V5UkJsU2w4aENva2FBR0dBOVZEN2NiUDNNZ0Zr?=
 =?utf-8?B?VURBZjh0Mk1IUGNPb1lVWllHR0Z3VHVSMXRNRTU4dDRQRUczUkN1NUdkK1E0?=
 =?utf-8?B?NVVYWk9VbzNGa2E4M2pzbmp4UklrYyt5a2F3bGxqZUludlB5RGhlSkNidUFS?=
 =?utf-8?B?blBac1dneFJTcGNJK0hXcnpJcDg1VkdHU00vdGRVR3VNbmxTTlNWZmxQcDFi?=
 =?utf-8?B?Ti9BNzNMdkFJeEpqVTUzeW1iQnBOaW01WENLUzBwV09zTjdpWEloejdpa004?=
 =?utf-8?B?Um1NTkRtY3dNV0t2Mk9iQ25Ec1JSZzlJeElGUE5JRW1Fb2xSSFVKblVocmRy?=
 =?utf-8?B?Z2hLZm5GQzhGQzRwdmUrN2dRR2VQZThZS1VhOTZydyt2QW4ySUY1QzdLRm56?=
 =?utf-8?B?eWN6eUJ3NUdQYVRKeXpnaXdES3JyNHprZkE4TFY5aG1PUkVlRCtyeFdTWEZW?=
 =?utf-8?B?RnBiME1DRFM0blZOOTFQVm1VWThjWXlnNkZpY3pYQUgwRUROOEs5b04xRU5z?=
 =?utf-8?B?RW50enBKZVFiVmdDaE5LLy94dld2SGIzcnpRQzIwME9jTS91ejlVYUlzdDFB?=
 =?utf-8?B?YUNxRDZkQTdBYXZzZk05T1VxMHJIclNySlJQTmlQNXp1MGJhSTNzZU9UVGww?=
 =?utf-8?B?SlBIbG5SbEp3bjE1aUlvbUJ0SW9aKzNGQzNOYXBVNFJKL1R1cS81WHBpbGhK?=
 =?utf-8?B?N0pUWHFhcTRUdkpXcFJWMkttdUt3TVQvbVhEc2FEd0ZyampOanlEQnFyeWNC?=
 =?utf-8?B?bElZNG1UVzlmSmVkQkpvN2dSUGVxZDNmNWdhVWNiTkE0YjFKVHNtcTBPSjAz?=
 =?utf-8?B?cWl0b0hGYzNvOVJaRXYwa090MjdCdWpZVDUrbkFJeDUwRVFXZGZkdGpPUzFu?=
 =?utf-8?B?dWtVWldUOElLcUIzWnRhRU9MRjhwdmMvZWFLL3h3TzBEZXBRZG9EdjZSV2lF?=
 =?utf-8?B?ang3MXlHbVlKNk80S3QxSUd6dktjQ0wwdVExL01EeWpZaHNnaktCWVJjbGYw?=
 =?utf-8?B?KzNHNmt3ME4rWmdmUHAyMExsdHJBbU1Hc1c3dmJXNnNyUXBLQ1VBclJqRDV4?=
 =?utf-8?B?RFNQbzcydEd0NTFDdWdqbXUyZlMvcTZxM3RsN3BSQUEva0h2ZkxEYXd3ZjRS?=
 =?utf-8?B?djA2Zy9kbmVMVW5rNHdic1YwN3VPclNEcklTRnc5bk54T1h2Z1V1NDViSTJD?=
 =?utf-8?B?VkU1NUJmdFVyOVRHdUNRUjc5STljbUlRNTArK3M3RlhyV2lOS3NObEZNd3pk?=
 =?utf-8?B?cmxoNHljR2RrMkxSNmozYS9kZWZaM1ZnWWlUcndxZWJZaURyUE8zQ0duSzhY?=
 =?utf-8?B?TVNwMmxTRk1hZTAvSHhaOVZXNlh4SHpJaDdpZTY1WVRtZEhVYzVLNDhNc2Fm?=
 =?utf-8?B?bTNOL3RhQTNQR3FOZVFmRExQUUE2YWc2NEJacUE0ZW1HTVR3Sm8rMytIU2RZ?=
 =?utf-8?B?QXFtOXQ0NmdwUVM5R0xlcVgyT3BvMmVvN0RrSnlPSXBTKzA1MDA4K3lhU2Nh?=
 =?utf-8?B?aW1zME9iWXRoQW02NnVOTkJXN2xyclRsSWgybGg4WEtRKzFRT0lDcUIrdWpp?=
 =?utf-8?B?VlFzc3hvZUtNMU9ucC9uL2JmblkyM01rUzFodERZZUZQWGtpRHZqMnhvL3VO?=
 =?utf-8?B?ZXJodkhiZVVrWEt2cmhFMlFVSXhvc3g2UVE5SzdlWW1oWVNFczI4M0NlVkxr?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3d524d-e0bc-43d2-d07a-08dabd12ffcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 20:44:12.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgr5vN8127WtLoRDQSpNzkeQTI3qLqylWNNtXLAsuB84L9m0hS7IWk6oTll1llybmgktZwBR5v8CS/VuzVbBH5VDWPaXYN0ffBULKsZE8Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwu
Y29tPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIsIDIwMjIgMTI6MTkgUE0NCg0KPiDRgdGA
LCAyINC90L7Rj9CxLiAyMDIyINCzLiDQsiAxMTo1NiwgTWljaGFlbCBLZWxsZXkgKExJTlVYKSA8
bWFpbHRvOm1pa2VsbGV5QG1pY3Jvc29mdC5jb20+Og0KPiBGcm9tOiBTdGFuaXNsYXYgS2luc2J1
cnNraWkgPG1haWx0bzpza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVl
c2RheSwgTm92ZW1iZXIgMSwgMjAyMiAxMDozMSBBTQ0KPiA+ID4gDQo+ID4gPiBXaWxsIGJlIHVz
ZWQgbGF0ZXIga2VlcCB0aGUgYWRkcmVzcyBvZiB0aGUgcmVtYXBwZWQgcGFnZSBmb3IgdGhlIHJv
b3QNCj4gPiA+IHBhcnRpdGlvbi4NCj4gPg0KPiA+IHMvbGF0ZXIga2VlcC9sYXRlciB0byBrZWVw
Lw0KPiANCj4gSSdsbCBmaXggaXQsIHRoYW5rcy4NCj4gwqANCj4gPiBJJ2QgbGlrZSB0byBzZWUg
YSBtb3JlIHJvYnVzdCBjb21taXQgbWVzc2FnZSwgYW5kIG5vdCBhIHBhcnRpYWwNCj4gPiBzZW50
ZW5jZSB0aGF0IGlzIGEgY29udGludWF0aW9uIG9mIHRoZSBjb21taXQgdGl0bGUuwqAgU29tZXRo
aW5nIGFsb25nIHRoZSBsaW5lcyBvZjoNCj4gPiANCj4gPiBXaGVuIExpbnV4IGlzIHJ1bm5pbmcg
aW4gdGhlIHJvb3QgcGFydGl0aW9uIG9mIHRoZSBNaWNyb3NvZnQgSHlwZXJ2aXNvciwNCj4gPiB0
aGUgbWVtb3J5IGZvciB0aGUgVFNDIHBhZ2UgaXMgcHJvdmlkZWQgYnkgdGhlIGh5cGVydmlzb3Is
IHNvIHRoZSBUU0MNCj4gPiBwYWdlIGFkZHJlc3MgY2FuJ3QgYmUgdGhlIGFkZHJlc3Mgb2YgYSBM
aW51eCBnbG9iYWwgdmFyaWFibGUuDQo+ID4NCj4gPiBJbnRyb2R1Y2UgYSBnbG9iYWwgdmFyaWFi
bGUgdG8gY29udGFpbiB0aGUgVFNDIHBhZ2UgYWRkcmVzcy7CoCBGb3IgYSBndWVzdCBWTSwNCj4g
PiBpdCBkZWZhdWx0cyB0byB0aGUgYWRkcmVzcyBvZiB0aGUgTGludXggZ2xvYmFsIHZhcmlhYmxl
LsKgIElmIHJ1bm5pbmcgaW4gdGhlIHJvb3QNCj4gPiBwYXJ0aXRpb24sIGEgbGF0ZXIgcGF0Y2gg
b3ZlcnJpZGVzIHRvIGJlIHRoZSBhZGRyZXNzIG9mIHRoZSBwYWdlIHByb3ZpZGVkIGJ5DQo+ID4g
dGhlIGh5cGVydmlzb3IuDQo+IA0KPiBUaGlzIGlzIGEgY2xlYW51cMKgcGF0Y2ggd2hvc2UgZ29h
bCBpcyB0byBwcm92aWRlIGEgY2xlYXIgc2VwYXJhdGlvbiBiZXR3ZWVuIHRoZQ0KPiBhY3R1YWwg
ZmVhdHVyZSAod2hpY2ggY29tZXMgaW4gdGhlIGxhc3QgcGF0Y2ggb2YgdGhlIHNlcmllcykgYW5k
IG90aGVyIHByZWN1cnNvcg0KPiBjaGFuZ2VzLCBtYWtpbmcgdGhlIGZlYXR1cmUgaW50cm9kdWN0
aW9uIG1vcmUgbGFjb25pYyBhbmQgY2xlYW4uDQo+IA0KPiBJIGRvdWJ0wqBpdCBuZWVkcyBhbnkg
YWRkaXRpb25hbCB0ZXh0IHRvIGV4cG9zZSB0aGUgZGV0YWlscyBvZiB0aGUgcmVzdWx0aW5nIGdv
YWwuDQo+IFdoeSBkbyB5b3UgdGhpbmsgb3RoZXJ3aXNlPw0KDQpUbyBtZSwgdGhlIGFkZGl0aW9u
YWwgdGV4dCBjbGVhcmx5IGFuc3dlcnMgdGhlICJ3aHkiIHF1ZXN0aW9uIGZvciB0aGUgcGF0Y2gu
ICBIZXJlJ3MNCnRoZSBxdW90ZSBmcm9tIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMucnN0Og0KDQogICBUaGUgZXhwbGFuYXRpb24gYm9keSB3aWxsIGJlIGNvbW1pdHRl
ZCB0byB0aGUgcGVybWFuZW50IHNvdXJjZQ0KICAgY2hhbmdlbG9nLCBzbyBzaG91bGQgbWFrZSBz
ZW5zZSB0byBhIGNvbXBldGVudCByZWFkZXIgd2hvIGhhcyBsb25nIHNpbmNlDQogICBmb3Jnb3R0
ZW4gdGhlIGltbWVkaWF0ZSBkZXRhaWxzIG9mIHRoZSBkaXNjdXNzaW9uIHRoYXQgbWlnaHQgaGF2
ZSBsZWQgdG8NCiAgIHRoaXMgcGF0Y2guIEluY2x1ZGluZyBzeW1wdG9tcyBvZiB0aGUgZmFpbHVy
ZSB3aGljaCB0aGUgcGF0Y2ggYWRkcmVzc2VzDQogICAoa2VybmVsIGxvZyBtZXNzYWdlcywgb29w
cyBtZXNzYWdlcywgZXRjLikgYXJlIGVzcGVjaWFsbHkgdXNlZnVsIGZvcg0KICAgcGVvcGxlIHdo
byBtaWdodCBiZSBzZWFyY2hpbmcgdGhlIGNvbW1pdCBsb2dzIGxvb2tpbmcgZm9yIHRoZSBhcHBs
aWNhYmxlDQogICBwYXRjaC4gVGhlIHRleHQgc2hvdWxkIGJlIHdyaXR0ZW4gaW4gc3VjaCBkZXRh
aWwgc28gdGhhdCB3aGVuIHJlYWQNCiAgIHdlZWtzLCBtb250aHMgb3IgZXZlbiB5ZWFycyBsYXRl
ciwgaXQgY2FuIGdpdmUgdGhlIHJlYWRlciB0aGUgbmVlZGVkDQogICBkZXRhaWxzIHRvIGdyYXNw
IHRoZSByZWFzb25pbmcgZm9yICoqd2h5KiogdGhlIHBhdGNoIHdhcyBjcmVhdGVkLg0KDQpDZXJ0
YWlubHksIGl0J3Mgc29tZXdoYXQgYSBtYXR0ZXIgb2YgcGVyc29uYWwgc3R5bGUsIGFuZCBJIHRl
bmQgdG8gbGVhbiB0b3dhcmQgdGhlDQoibW9yZSBleHBsYW5hdGlvbiBpcyBiZXR0ZXIiIGFwcHJv
YWNoLiAgQnV0IGlmIG5vIG9uZSBlbHNlIGNhcmVzIHRvIHdlaWdoIGluIG9uDQp0aGUgdG9waWMs
IGl0J3Mgbm90IGEgYmxvY2tlciBmb3IgbWUuDQoNCk1pY2hhZWwNCg==
