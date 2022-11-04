Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106D61A2AC
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 21:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKDUuc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDUub (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 16:50:31 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020016.outbound.protection.outlook.com [40.93.198.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FBA46B;
        Fri,  4 Nov 2022 13:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk50gz+3yitnyFFHMe/A6XxpBukLBUpJbFnXqM4w9nTThSHmFIz9P2h+XxxIfdNTCc52pObYB6kuChFCpg9/4rH6p2Xk71kvuhXGU8OgUGFpL/+a1VQCTo/61eT96TtCWA6qn/Y3i2R/E43ePH5NKvn92wU1H4cbHAoc0SwrZVby+iCddOAFoLUQ6MgCcNIyJYjt3U7OH/4eXOn2lPFFIn8LLdGxwnh1tsIPQvTI4jfaQSZyRd5RyDzr5IdBq/VyE5nqpFtxgJCWFpxNM0PtstPKWEu6SJTyt2CG/oRX7bwSWdxBZneC87RbEzJrJwBIN387zEP+8++OiutorcwomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX1DViLAbg4UmKOdUZ1a9YulRAgew0ig2c2h5JZN40s=;
 b=n2UI4vjWSMAomLqPTOTQ05wJ9ynpWg1HEbPMNlZvTZ/teYXhuS+QdetgzIdfOSYBavCCIAa6JN0GpiurFvVL69yBuU4aBXV4sPI3bLnSdfi9WsLuR5K9l7R0mqfXGeYyxETz8qNzPwQtcuTut40fYzUI2OlGo4o8LUWaN6pdHLrxbNkK7JQjYgBKxEkFWCvpoJ0J7YRzA8BGi/2EKod2GveluuhM+v3V+JzuCLPGwCIFpts6YqNSwDXvKw4spRQYqPsvL+iGvo5uLJkbydxZOcAFkL6abq1spZ59ya4Aj3uZS0AKyqL/Cn3M6b1nT3WJ0ZaPNTYlaHwaeSMvYvQD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX1DViLAbg4UmKOdUZ1a9YulRAgew0ig2c2h5JZN40s=;
 b=R9U8WZgLKtpjXZ/XUgh3RO5JQ9e5D5HL2Es6GeIYNdPoGoMl9err+3YrkGCQ1+R2mWXP5MH+gYdFJTwB2gc+oiKGOzcmw6uvP6MdTqMfnS+BSHJdtBzqsxI0TOmAaKlXBMVwq7dofLRXKGjUDOyRjMOTo5uODodN+xAHI4IWCXU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3560.namprd21.prod.outlook.com (2603:10b6:8:a4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.5; Fri, 4 Nov 2022 20:50:25 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 20:50:25 +0000
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] drivers/clocksource/hyper-v: Add TSC page support for
 root partition
Thread-Topic: [PATCH v4] drivers/clocksource/hyper-v: Add TSC page support for
 root partition
Thread-Index: AQHY8I2+vyS7bNMhVEqV7CosQCmlvq4vPLoA
Date:   Fri, 4 Nov 2022 20:50:25 +0000
Message-ID: <BYAPR21MB1688DFABEB724EBD09327B3CD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <BYAPR21MB1688D81DEFA482E52653955FD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <166759443644.385891.15921594265843430260.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166759443644.385891.15921594265843430260.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8fee93ca-0c89-40b3-9bac-8367a638a3f2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T20:49:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3560:EE_
x-ms-office365-filtering-correlation-id: 6a2ccb10-e02b-43e5-e9b7-08dabea6332b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2P6i4mrA3+41QPWqOY1RP05jLlTp9K1dUSp1t8G+BkkDUjnJurNfnzfXzTSWJuzXiOydYHZUTcLlz1jgWBituh6DAFj78a2s5l+jTj0cHnT4PwK2phPSaf2dj6HIZtH808BJLxg3KACwURUiFL4oe7DYUHSR4rGDHkG9+d666srGSQguMAO1EjScOcLp6pPMeThoKTmTMTrI8YW8IBwje2DAgnsCL8KKr2W+wWEp98msJMB8DvNnXA4/nGw8sTof5zejmaewqzZ/XHrjJ8p/jnuY8wZmdeBrFdtIyIDkNBJhSE0Bk3eViodeIoMiriv8YyczbZmo4ahUxDzq15ZzTiXizwo5cSfZhO5gQkuSvWBd7WQ/X2Vumf0clZu+70Sc4uS7+g7WrgUVUwPvMbg7Zc1V23C6gwlHkF5y/9CCEgjESMkEQP26hULPSAOkUegkNRRUim8l75FK1r5M4DE6pAOkIAENiYNkNlK0skGTIe5SHg1VoMqbAbBCNzzYUzrzqRyWCxYt7H7cPkGNy3+CGEy93DMMNMZfKa6dalhVN9lOxxN7FwLPK72I42tKxIcwRQKs8g7ypFQP5V3irJnWhh1V1wOOAtgpHNQQzXrlSG+k7rhtvdfZtu+fcZvPHOOp4iqeQk7MGopwFU4q+ybX+1f/VTs+kWMIWvxOHITZRiUuYGUlOJIrt0nvkz96aqIfeuV/XukLkMVNoSpdhhAdLf3dxUVKeIu7JcUsqs8P5rco6PmoMOgR4mfJfcL+udCXOvylyTag2Yuvhv7xi44C8E0nKzt84vFrNCUq6sJd5jXay2vjU+OKFcUW4Vg87S1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(52536014)(186003)(478600001)(41300700001)(316002)(8936002)(33656002)(54906003)(6862004)(9686003)(122000001)(66556008)(26005)(64756008)(82950400001)(8676002)(55016003)(66446008)(82960400001)(38100700002)(71200400001)(10290500003)(4326008)(66946007)(66476007)(86362001)(7696005)(76116006)(2906002)(38070700005)(6506007)(66899015)(83380400001)(5660300002)(8990500004)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDI3bzlwcHpuR0NhajMvZHFiODNaYVpRcEJ3dlh6ckdrTmoxOUxXZ2p5eXZY?=
 =?utf-8?B?TnBTckhwUHFlTSsrVm1FMkQwNmIxTno2MVRBR3ZkZnRna3Z2WDBhdWZINFR6?=
 =?utf-8?B?SmtGaDlJS1NIRDFCQU1iY2srRjJNVkVDOG9meWsyRVBBckpmYnFLa1EzYWpj?=
 =?utf-8?B?TzQyNitXLzdMV1c2YXJRVEtaazlTWWVZdWJPYnUrUDFkTndFN2JXZkJ4MHJN?=
 =?utf-8?B?V08rZnlFeG9TM1d1RXVIbVdDZnFNbEFpR2wxa0tnVHNHUDA5WHhURGcwVXJM?=
 =?utf-8?B?SU8vbTU4NW04ZkovbDhZN25XZi9YWncvSTBiNDJqVExGdTNjVTNNU01JNDM3?=
 =?utf-8?B?dDNGRytYUG5hTVgycmdsUXc1UVVvWXBXOUxMS1JnQzh2MmdMRkJwV3dYbklT?=
 =?utf-8?B?TGFaWkhZTGdNV2NFTVVuZkxocUs3VFNkWm9SaDh5N2pYV2djVk40OVZSYVIy?=
 =?utf-8?B?Q1UwaTRaaE9EYnc1Z2o5dXhyQUd2SU5qdFdGY1dYRUd6ZVR0WkpudXIvUTd1?=
 =?utf-8?B?MjFocVJqUjFjMnFEN09NWmx3cGx1MG9adFcwWXN5SEdEVUJPU0lNN1hFakxU?=
 =?utf-8?B?MHlSYUJrRkVkQWJGR2ZHV1lYaTlWemNFd3Z2MFNnTXZwQjNMajgwSXM5eUdD?=
 =?utf-8?B?Ull3aE9wSFZDMGYrVWJqUFQvWVZtdDlMZzNmaEVZLzcwMGJiOU5kZlAyK2dU?=
 =?utf-8?B?MFlOOUpQOEVSQmlkZXhhb3JqTThLb3J3VHdka29BL0lrUXkrVVVaRktxQU9w?=
 =?utf-8?B?dlNVQ2t0eFdaS0thUnhtdGlOSTZVeXVLeDZVSWdoSFhHWGN5b3hjSFF0dlpB?=
 =?utf-8?B?eUNyQU83Qk9TWWYxQ3F4K0dLVzBubU9pNWxEVkIwbG51ZkkweDVZODRWQm1W?=
 =?utf-8?B?Q2pVUEVHbFF3MU43azkxWDFncTRyWWFhekVwVzdJWTRoRERwWU8xdHVEWjJR?=
 =?utf-8?B?Nkh2eHpiZ1BaZ0FLalNrdFJjUEswY0JZSlI4UXY3b2FTRkJEclc4VUoveTNY?=
 =?utf-8?B?ZVJGbjZHVTMwTUZqbHdCQkY4RWxWd21neFNmTDkyMDdUWm52Zm5sMUdxYnJB?=
 =?utf-8?B?Z0ZYTE03QXdTOXFZb0FRSFhkNWJoK3liK3VyQ1hRZVhaMVZGcU1MOU0yWGZL?=
 =?utf-8?B?djR6L3RQK1F1WG9weGg4elFJVmN4SDFoWC9kU1hpOEliaDlHMFVaUHV3VWR3?=
 =?utf-8?B?L1E5NExyNlhackUvMHVnMUdLVmJrVFFrWHpBZytzMGRNRVM2R1VMM1AxbnZO?=
 =?utf-8?B?TlpCMGhLSHZLaU5XS2RMTGpJelVqOVVodWo0UW5QMjNiN1kwY2ZCd2IvOHlQ?=
 =?utf-8?B?VGc0Tkl6MnFWa2NRa1pBZGxBSVlnaFUyV2lXdWQ1QlBQSE9VMzk1UUg1MmFJ?=
 =?utf-8?B?aDJDdnFJKzJCTUFVVU5RREdkLzMrczJMOTZmL2h4cEsrRnZoN2pRSm9CRGwy?=
 =?utf-8?B?ZFR3R0ZxU2tjQ3I2cnR0Vjk3ek8wZ1lOcm1DMks1Tkhld3AvWXNZeTFmam82?=
 =?utf-8?B?WHQ2eGw5QjVQNGFnRVJ0VU1jay90ZVVxazVKSDArQW1KRm9XVjFCakg4V3hF?=
 =?utf-8?B?ZjZ2REVMaFhoWlNKUFY2NjFyTldYbWtBNGZ0RHp4bTVOSmFOL2taemtpcFpZ?=
 =?utf-8?B?Z1h0U01saU5UZ054N2N2dnNFeG43UUhwTGMyVE51TzBKZTl5SWpHcDhUZUVF?=
 =?utf-8?B?TFB4RWdEaTRCcERDaTIrSzNUM2w1azU4alhsdmlpZE9JMjJlS1Z3TjFhbFBV?=
 =?utf-8?B?eXhGcDJQczNXZmR4dCtzMDNyWFE2TjRMMFNuYzVyb1RINGg1TlYwWDRrQkpI?=
 =?utf-8?B?RXFIWWtBM0poczdNYTlBcXhSL1Nod3luZkF4L29zNnBiakRkandlT25CK3FY?=
 =?utf-8?B?NXZmbzBuUklvYjFzUGw2UnJjaWFEcEIrU2h6aHlZbURMRFNES3hYRHUrbEFu?=
 =?utf-8?B?WHdvSXExcysveUxpRGZLUWN2T3Yvd0tDbHRvK3pLL0NhNWh2OU9IRjVJVExY?=
 =?utf-8?B?Q0pyZDhUM2Y1RThpeEdpeG5PVzFhcHBIYnJad2QxMjBkbUhsR0NTR0ZFbkls?=
 =?utf-8?B?UXhxWlZWYmZmcGxUVWU2YVIxc3ZTRy9QYmRiSjQ1Rkk0ZDNDeGk1ejZyWkE5?=
 =?utf-8?B?OUdtNG42RVpxaE9OZmdCdy9KeGNKcDRmd0cwT01JVnhmVnFuM3J1MVEzQmtM?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2ccb10-e02b-43e5-e9b7-08dabea6332b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 20:50:25.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DahwvVrKErDid96TtGy35324i5cSAgc9MclPByxvei41iLg3DjXNK5zmVzaZGmL1xPHSAh4l+f+j0L4D9LzH4N8bIIgaslwnhAZ5oAl2D5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA0LCAyMDIyIDE6NDEgUE0NCj4gDQo+IE1pY3Jv
c29mdCBIeXBlcnZpc29yIHJvb3QgcGFydGl0aW9uIGhhcyB0byBtYXAgdGhlIFRTQyBwYWdlIHNw
ZWNpZmllZA0KPiBieSB0aGUgaHlwZXJ2aXNvciwgaW5zdGVhZCBvZiBwcm92aWRpbmcgdGhlIHBh
Z2UgdG8gdGhlIGh5cGVydmlzb3IgbGlrZQ0KPiBpdCdzIGRvbmUgaW4gdGhlIGd1ZXN0IHBhcnRp
dGlvbnMuDQo+IA0KPiBIb3dldmVyLCBpdCdzIHRvbyBlYXJseSB0byBtYXAgdGhlIHBhZ2Ugd2hl
biB0aGUgY2xvY2sgaXMgaW5pdGlhbGl6ZWQsIHNvLCB0aGUNCj4gYWN0dWFsIG1hcHBpbmcgaXMg
aGFwcGVuaW5nIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJz
a2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBDQzogIksuIFkuIFNyaW5p
dmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6
QG1pY3Jvc29mdC5jb20+DQo+IENDOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+IEND
OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDQzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNv
bT4NCj4gQ0M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDQzogRGF2ZSBIYW5z
ZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ0M6IHg4NkBrZXJuZWwub3JnDQo+
IENDOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDQzogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENDOiBsaW51eC1oeXBlcnZAdmdlci5r
ZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAg
YXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAgICAgICAgICB8ICAgIDIgKysNCj4gIGRyaXZlcnMv
Y2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgfCAgIDQ0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLQ0KPiAgaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCB8ICAg
IDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMgYi9hcmNoL3g4
Ni9oeXBlcnYvaHZfaW5pdC5jDQo+IGluZGV4IGY0OWJjM2VjNzZlNi4uODk5NTQ0OTBhZjkzIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ICsrKyBiL2FyY2gveDg2
L2h5cGVydi9odl9pbml0LmMNCj4gQEAgLTQ2NCw2ICs0NjQsOCBAQCB2b2lkIF9faW5pdCBoeXBl
cnZfaW5pdCh2b2lkKQ0KPiAgCQlCVUdfT04oIXNyYyk7DQo+ICAJCW1lbWNweV90b19wYWdlKHBn
LCAwLCBzcmMsIEhWX0hZUF9QQUdFX1NJWkUpOw0KPiAgCQltZW11bm1hcChzcmMpOw0KPiArDQo+
ICsJCWh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSgpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWh5cGVy
Y2FsbF9tc3IuZ3Vlc3RfcGh5c2ljYWxfYWRkcmVzcyA9DQo+IHZtYWxsb2NfdG9fcGZuKGh2X2h5
cGVyY2FsbF9wZyk7DQo+ICAJCXdybXNybChIVl9YNjRfTVNSX0hZUEVSQ0FMTCwgaHlwZXJjYWxs
X21zci5hc191aW50NjQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBl
cnZfdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gaW5kZXgg
OTQ0NWExNTU4ZmU5Li5jMGNlZjkyYjEyYjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xvY2tz
b3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZf
dGltZXIuYw0KPiBAQCAtNTA5LDkgKzUwOSw2IEBAIHN0YXRpYyBib29sIF9faW5pdCBodl9pbml0
X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAmIEhW
X01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRSkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gDQo+
IC0JaWYgKGh2X3Jvb3RfcGFydGl0aW9uKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gIAkv
Kg0KPiAgCSAqIElmIEh5cGVyLVYgb2ZmZXJzIFRTQ19JTlZBUklBTlQsIHRoZW4gdGhlIHZpcnR1
YWxpemVkIFRTQyBjb3JyZWN0bHkNCj4gIAkgKiBoYW5kbGVzIGZyZXF1ZW5jeSBhbmQgb2Zmc2V0
IGNoYW5nZXMgZHVlIHRvIGxpdmUgbWlncmF0aW9uLA0KPiBAQCAtNTI5LDE2ICs1MjYsMjggQEAg
c3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nrc291cmNlKHZvaWQpDQo+ICAJfQ0K
PiANCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVyID0gcmVhZF9odl9jbG9ja190c2M7DQo+
IC0JdHNjX3BmbiA9IEhWUEZOX0RPV04odmlydF90b19waHlzKHRzY19wYWdlKSk7DQo+IA0KPiAg
CS8qDQo+IC0JICogVGhlIEh5cGVyLVYgVExGUyBzcGVjaWZpZXMgdG8gcHJlc2VydmUgdGhlIHZh
bHVlIG9mIHJlc2VydmVkDQo+IC0JICogYml0cyBpbiByZWdpc3RlcnMuIFNvIHJlYWQgdGhlIGV4
aXN0aW5nIHZhbHVlLCBwcmVzZXJ2ZSB0aGUNCj4gLQkgKiBsb3cgb3JkZXIgMTIgYml0cywgYW5k
IGFkZCBpbiB0aGUgZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzcw0KPiAtCSAqICh3aGljaCBhbHJlYWR5
IGhhcyBhdCBsZWFzdCB0aGUgbG93IDEyIGJpdHMgc2V0IHRvIHplcm8gc2luY2UNCj4gLQkgKiBp
dCBpcyBwYWdlIGFsaWduZWQpLiBBbHNvIHNldCB0aGUgImVuYWJsZSIgYml0LCB3aGljaCBpcyBi
aXQgMC4NCj4gKwkgKiBUU0MgcGFnZSBtYXBwaW5nIHdvcmtzIGRpZmZlcmVudGx5IGluIHJvb3Qg
Y29tcGFyZWQgdG8gZ3Vlc3QuDQo+ICsJICogLSBJbiBndWVzdCBwYXJ0aXRpb24gdGhlIGd1ZXN0
IFBGTiBoYXMgdG8gYmUgcGFzc2VkIHRvIHRoZQ0KPiArCSAqICAgaHlwZXJ2aXNvci4NCj4gKwkg
KiAtIEluIHJvb3QgcGFydGl0aW9uIGl0J3Mgb3RoZXIgd2F5IGFyb3VuZDogaXQgaGFzIHRvIG1h
cCB0aGUgUEZODQo+ICsJICogICBwcm92aWRlZCBieSB0aGUgaHlwZXJ2aXNvci4NCj4gKwkgKiAg
IEJ1dCBpdCBjYW4ndCBiZSBtYXBwZWQgcmlnaHQgaGVyZSBhcyBpdCdzIHRvbyBlYXJseSBhbmQg
TU1VIGlzbid0DQo+ICsJICogICByZWFkeSB5ZXQuIFNvLCB3ZSBvbmx5IHNldCB0aGUgZW5hYmxl
IGJpdCBoZXJlIGFuZCB3aWxsIHJlbWFwIHRoZQ0KPiArCSAqICAgcGFnZSBsYXRlciBpbiBodl9y
ZW1hcF90c2NfY2xvY2tzb3VyY2UoKS4NCj4gKwkgKg0KPiArCSAqIEl0IHdvcnRoIG1lbnRpb25p
bmcsIHRoYXQgVFNDIGNsb2Nrc291cmNlIHJlYWQgZnVuY3Rpb24NCj4gKwkgKiAocmVhZF9odl9j
bG9ja190c2MpIGhhcyBhIE1TUi1iYXNlZCBmYWxsYmFjayBtZWNoYW5pc20sIHVzZWQgd2hlbg0K
PiArCSAqIFRTQyBwYWdlIGlzIHplcm9lZCAod2hpY2ggaXMgdGhlIGNhc2UgdW50aWwgdGhlIFBG
TiBpcyByZW1hcHBlZCkgYW5kDQo+ICsJICogdGh1cyBUU0MgY2xvY2tzb3VyY2Ugd2lsbCB3b3Jr
IGV2ZW4gd2l0aG91dCB0aGUgcmVhbCBUU0MgcGFnZQ0KPiArCSAqIG1hcHBlZC4NCj4gIAkgKi8N
Cj4gIAl0c2NfbXNyLmFzX3VpbnQ2NCA9IGh2X2dldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZF
UkVOQ0VfVFNDKTsNCj4gKwlpZiAoaHZfcm9vdF9wYXJ0aXRpb24pDQo+ICsJCXRzY19wZm4gPSB0
c2NfbXNyLnBmbjsNCj4gKwllbHNlDQo+ICsJCXRzY19wZm4gPSBIVlBGTl9ET1dOKHZpcnRfdG9f
cGh5cyh0c2NfcGFnZSkpOw0KPiAgCXRzY19tc3IuZW5hYmxlID0gMTsNCj4gIAl0c2NfbXNyLnBm
biA9IHRzY19wZm47DQo+ICAJaHZfc2V0X3JlZ2lzdGVyKEhWX1JFR0lTVEVSX1JFRkVSRU5DRV9U
U0MsIHRzY19tc3IuYXNfdWludDY0KTsNCj4gQEAgLTU3MywzICs1ODIsMjAgQEAgdm9pZCBfX2lu
aXQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCWh2X3NjaGVkX2Nsb2NrX29mZnNldCA9
IGh2X3JlYWRfcmVmZXJlbmNlX2NvdW50ZXIoKTsNCj4gIAlodl9zZXR1cF9zY2hlZF9jbG9jayhy
ZWFkX2h2X3NjaGVkX2Nsb2NrX21zcik7DQo+ICB9DQo+ICsNCj4gK3ZvaWQgX19pbml0IGh2X3Jl
bWFwX3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiArew0KPiArCWlmICghKG1zX2h5cGVydi5mZWF0
dXJlcyAmIEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRSkpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCWlmICghaHZfcm9vdF9wYXJ0aXRpb24pIHsNCj4gKwkJV0FSTigxLCAiJXM6IGF0dGVt
cHQgdG8gcmVtYXAgVFNDIHBhZ2UgaW4gZ3Vlc3QgcGFydGl0aW9uXG4iLA0KPiArCQkgICAgIF9f
ZnVuY19fKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCXRzY19wYWdlID0gbWVtcmVt
YXAodHNjX3BmbiA8PCBIVl9IWVBfUEFHRV9TSElGVCwgc2l6ZW9mKHRzY19wZyksDQo+ICsJCQkg
ICAgTUVNUkVNQVBfV0IpOw0KPiArCWlmICghdHNjX3BhZ2UpDQo+ICsJCXByX2VycigiRmFpbGVk
IHRvIHJlbWFwIEh5cGVyLVYgVFNDIHBhZ2UuXG4iKTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4gYi9pbmNsdWRlL2Nsb2Nrc291cmNl
L2h5cGVydl90aW1lci5oDQo+IGluZGV4IDMwNzhkMjNmYWFlYS4uNzgzNzAxYTIxMDJkIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQo+ICsrKyBiL2lu
Y2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4gQEAgLTMxLDYgKzMxLDcgQEAgZXh0
ZXJuIHZvaWQgaHZfc3RpbWVyX2dsb2JhbF9jbGVhbnVwKHZvaWQpOw0KPiAgZXh0ZXJuIHZvaWQg
aHZfc3RpbWVyMF9pc3Iodm9pZCk7DQo+IA0KPiAgZXh0ZXJuIHZvaWQgaHZfaW5pdF9jbG9ja3Nv
dXJjZSh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIGh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSh2b2lk
KTsNCj4gDQo+ICBleHRlcm4gdW5zaWduZWQgbG9uZyBodl9nZXRfdHNjX3Bmbih2b2lkKTsNCj4g
IGV4dGVybiBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCk7
DQo+IA0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5j
b20+DQoNCg==
