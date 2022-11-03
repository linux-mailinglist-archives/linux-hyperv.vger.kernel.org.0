Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F70618A0A
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 21:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKCU61 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKCU6Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 16:58:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022018.outbound.protection.outlook.com [52.101.53.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB392601;
        Thu,  3 Nov 2022 13:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY355rbM5KT7EoiukxWPZlbzybqb1KbvxhxqXcG2hwFoEC2LyGKOSazfi+yzWDxKOBjatFbTsOrDCm/ksEQEBSsb0mtixP4zD4XUTMuuJQIhVhAJhGvR0eLXF+ugq7BdFQdcVDhlHUYQqyH2cHRGVFf3vEH75AFkmLIPUQ4HG5e/gbeWd7qB82Z97mSGW7PF413q70MKouNi9ps453sh4i0DKcIV7wLn1c+3JYWg8YHGYjtQPSM7KH7Drd0V1LvaxnPjff34E1iEPw3p4+CkDGDjqAELz8OqZjbo6JtocZSRjOHXxw6SzL95oKjf1bo0dJeo5MiGMAG5PcbbZEBR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs7+GonedCZHvGpbFMUKYeyr7RwppR2bta2iRkhPd2U=;
 b=msS4GGypOTw/szfK1V5Aw8A0H460JOdF4KvOV8EOe4kTN/WVP6N7JXD1B36pnndyM1l9t8y8OTBgJfv8IehYtPCa8BDmDrlmdFekJrthnzXtEwWoGvDF6RP+/S7SsGoRFTrJ5rKqf2SGtk00XcjLrnBDMmKkCXJIGpS0yC9WISocWFOnuVrXgVZ5m0zUTzLWPJP1J5y7o4pQX986S6YWDUlNjxsCy/ekQ7olFPg/E3ZjPngYpcPL5FzmU3qz3VoENLr63IDZeVMGagPZWcZHRxdyPjYokmVi1ZKv9ZOpTjL4/DXfT/y/6Qb8ciqODzQTb/J8DhhbcoBI0cSbAZd/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs7+GonedCZHvGpbFMUKYeyr7RwppR2bta2iRkhPd2U=;
 b=FVSQ35MaaJVf2DGE2BA9BvgfYv+GXUcK2cxqkGEKmZ9kKudqL7nDKCAO/keqSostVGhi8tkNC6WBUX23wc6y9Nx7KLUrmioIu/nWL9nojyK5S+a53/EtTOJJyFOygRpwXQNoUAmtGX6NxdywvBt6HtwQFtfw7goq2NsBOjuF37g=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1879.namprd21.prod.outlook.com (2603:10b6:510:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Thu, 3 Nov
 2022 20:58:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 20:58:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] drivers/clocksource/hyper-v: Introduce a pointer
 to TSC page
Thread-Topic: [PATCH v3 1/4] drivers/clocksource/hyper-v: Introduce a pointer
 to TSC page
Thread-Index: AQHY763vlFPXpb6SBEWozQirFm8Kja4troAA
Date:   Thu, 3 Nov 2022 20:58:21 +0000
Message-ID: <BYAPR21MB1688154D48A898AF4F53CB51D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749832893.218190.16503272948154953294.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166749832893.218190.16503272948154953294.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b35786de-03f8-4716-a146-d15732d5daf8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T20:57:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1879:EE_
x-ms-office365-filtering-correlation-id: e1f3caa9-65d3-4608-f6a4-08dabdde2418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4mOenRYEPeGRUbROmOJ1SpDes0AfvTfrqSRuBrYhBpZr2eMDPcJqeWZsvtoq9nmrj070HO+mcshwgQW97EAGXnh0tkTtADXo1Sqp7NRUbzZCFQs36fxjCB8IdXS84OsigZqyzap/4qPIyloDSm0OZosvmJ6dwpGkl3ScZEiRuS0t0yfPAU/S2yUsBLtjYh/ZQi1KDBKhWcNx0ndlYJHLwO0uTFDlHLEft3PCPzpGSNnns4PT8/0HoBU7uE0GA+kSU690XzhRlwiu6/5sNQhq1umg5OdzBDTz7U+qpn+aX5Dq7C4CD+6MloISeqGOu8RiHasXlsWxft+wnTI1NcuyJUoDN3YBE1ng4QBXt22dD1u5GGsRIztL7+o4ayPPX3nvJQht2cYVc4B9honpO7YhMcETf2dydh4LKVa9R5Nksq8L5QiPJG0+leIN1WlzTvzXgv+wmVkMJKskJmNDQ1DtGrJfPAhRa6J5Ss0ikKLi3D+BCaTsW7L8Wt6AIfpAfWGoMUCv9jFkk1O8I1PRMnKkrcZGWOq+9u/JV3NblXGUitdxpHYYEEWd3caBb1zRza06d/3MPCVcAWSmin9oPdVAz5IR8itileR9s7MjjOx3kucc8P93XWJ07HJLSDOJ9eIa6MeZhdXtTtygC8iuMiWVUqlxpE89y3rcJasjd4Rc54OkxYwFl8U+3YXeqm8IhrkXbXAaHImWhimT4jAWKHtRNW5LRGkWTqSvd2Ah0VHy7XKArycOBZ/FpGjHCBhr9ZsySOIyqoc6T4IAzqU0l3wM49fIRXjmYqG1bXOZxInXufHx/PtzTd71VAizKnxTK7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(186003)(9686003)(83380400001)(6506007)(26005)(7696005)(2906002)(122000001)(55016003)(8990500004)(71200400001)(54906003)(10290500003)(316002)(64756008)(478600001)(76116006)(5660300002)(41300700001)(8936002)(66946007)(4326008)(6862004)(8676002)(52536014)(66556008)(66446008)(33656002)(38100700002)(82960400001)(82950400001)(86362001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pkamtQZUJHblhHb2pjUEgzN3hnU1VJeXFjSEtmb1lJRURQZXhXWnl3VWFL?=
 =?utf-8?B?cVVmSEFDRGxmQ1hPRUJ4QnFmMDdYbExVbWdNZ1JPS2lUZHZZOWh6RW5MMURW?=
 =?utf-8?B?c0RWNHRNVWhCamJEUVJ2YW5xVWR0cDdHdmZFTmk5QXo5Sm40Z3VReTdSNXZw?=
 =?utf-8?B?Zjg5N3BNTnVSZXRNMUp3cHhUQ1RvelJZS2JMQzFhYTFYSDJJOVp0U2l4a3dL?=
 =?utf-8?B?TlZrSCsvVEVBSmlVZEVQdkJZeURzckswTS9xZWpFZlRkZWFadU0yLzBvUFU0?=
 =?utf-8?B?cW04R0l2czZ5N2JhZlhmM0lnWVc5d21ralFLYmNlaXFHa1VxTzFQc1BJbW5q?=
 =?utf-8?B?TTFSRFRvM3FSc0h5aHVYUmtZempWL3JJSEpCa0xnUnNSN00wcWg1RkVleWtw?=
 =?utf-8?B?NXhqZVFvalpjaXBnOGJYZmRoZXo2bE5FeUhnanlsSm9aTWFlbTkyWmFMcTlr?=
 =?utf-8?B?SkFEbndLMDUrZ2p0TEk4Zmc5SU4wZDEvdGY3WDNxS2g4RHU5NWNIV0NWck84?=
 =?utf-8?B?d3A0ZnJwcmduRFhHOURuTlEySHBJNDRYaTFwbDhyUmF6QXpKR1JUc0hKbGF6?=
 =?utf-8?B?R0VUN2F1SkdpbU9FVGlsUXRDMVZqcHh3QmxNMU1EYjl1WlNGb1h4aWJCMVJH?=
 =?utf-8?B?Q2RveXNmQXUvdU5TTkdBakhFaFBaUSsxdHNDYzhGRFJZam11VGJGdDdKeEpI?=
 =?utf-8?B?Ni8zeElWNXBlR2ZhSURvSkZyK2RORUl6VnRLNEVlS3JCbFZDR3p0cStub0Fx?=
 =?utf-8?B?L2F0VGxyOGMyNDdRbWw1cmJxdFEyNFVxa3B4VjY1WnZoMHgxNFR0VWoxNGdS?=
 =?utf-8?B?NGtwc2kvWlZPeUI0WXZTYUlIN1BPYnp4cXB0NUFrYUdkc3VFcmZ2MTFtRmp2?=
 =?utf-8?B?WVVYblQ1YVZjNlVSNTJsTVVLNnFEMFEzbUdrRlJrcHpLOERaMHh5SmhIQmhZ?=
 =?utf-8?B?ZzV3cHdiNDk4OUhHSEU0SGhodWNFNzZDanNlR2RBT0NOUVpudkE4WkVOYTRp?=
 =?utf-8?B?R2Vkb002N09qbTlIL0dwMVhlNm03Uzg0UVlsT3hwRXhPeTFhSVpuSzY5QkZO?=
 =?utf-8?B?bityZTl2L1ROaTJLTVJQNU85OGJkOWwrVldDczRMRWE3eks5L3o3WDlKcStY?=
 =?utf-8?B?WGVlL00zR0E1Q1JzTTFMZGc5NEdsOWFXajQwTTgzRDJtbFdCWmFDV0lkRG9S?=
 =?utf-8?B?MWk0ZWRtYityWlNVUW1tTlNicjJKOE1uWDhZTmpsaDNTYW1BK2dhUkwxeHh6?=
 =?utf-8?B?MDVOUC9WVXBsdHhiVWU5MVY1Y1ZYSXpOVVNzVWRWS29lSk5jcVFrbTJkWk5Y?=
 =?utf-8?B?bHYzUVNicEROVkpwWTRCRDllNzJkNFdCMll0NVY0dmZiU05KYWhVTGF2R3pS?=
 =?utf-8?B?Q3ZmcUlsVjJlampBeUNQY0VjK3hEMFJYQ29Cbm5jS1JOa3J2NjA5NTErSkV3?=
 =?utf-8?B?cExvbHF1ZGZmTGZXeXo3UWhkWWxKZGMydU1rTm1TVDRDSkI2OTJjU0VTN0NV?=
 =?utf-8?B?cGNtRGhuaURmMzdrNEF0ckl2aWpLSVp6L3lOR0FBdGEvOFZ2NXZjdHVYSjBX?=
 =?utf-8?B?ZkhsaXk5ZzFNbnNGMEdBOGY1QmNNdFR0KzZjaEltR0lQYnBlQWJLS1V5K3pN?=
 =?utf-8?B?dXpQbUp5MXlLajRGVVNpWTIzOUR1dFpoT1FQU25GR25wODZ1aE9kc3BKMm00?=
 =?utf-8?B?RlRVc0JpbUJRVTFTVW1TRFpFWDJLRkxYTUVUM1JKcTdpRExDQVB3ZitxZ3dy?=
 =?utf-8?B?R1hzMTVrS2laM3VzRXdyZGh4N2ZqRHd6eXQ4a3hqQUZYcTdmTWVWOUI4NE1v?=
 =?utf-8?B?Z1RmVkU5L3VqT2FNdjZ2SDJZY2wvQnBlWURwSFliRTExZzM3MXhlSDQ1Rmg2?=
 =?utf-8?B?QXVVYXMwWW1YRVVuYUVwT0RUYnZhdHBDd09BOXhmenJxVG9jejdpSktydHk0?=
 =?utf-8?B?L1E0c1Q5Q2VhMzN0dG9JOXRnTFJzWUpVdTAyeEtyN3hMUUdLalZXeW9kTSsw?=
 =?utf-8?B?ZnJUME1vdzI0bXA2ZExWU0RlVXViRDZxUndxZUtNYTNNckg2UTcrRk9HbXUr?=
 =?utf-8?B?YmhkWVJFS2lSbGliUVZkS1hhVkhZeThwYVB6eGl3M1hBTnZCekpjVEgzd0I2?=
 =?utf-8?B?RGJHUG9FY0ZNSkM0TzUzWjFuM250M3oyV3ZROUtEVjQweE10RmNyNEx0YkQv?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f3caa9-65d3-4608-f6a4-08dabdde2418
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 20:58:21.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/HLyY4lBRRRg70HRqvyAAlOnY7R1ntP85TG/KW6HUNuofq9wYhEGmt1Nz+NKRQbmF6WcypgORFQ2fIPJrAluBcLlB5Aa6IgIgr8T6nBrvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMsIDIwMjIgMTA6NTkgQU0NCj4gDQo+IFdp
bGwgYmUgdXNlZCBsYXRlciBrZWVwIHRoZSBhZGRyZXNzIG9mIHRoZSByZW1hcHBlZCBwYWdlIGZv
ciB0aGUgcm9vdA0KPiBwYXJ0aXRpb24gYXMgaXQgd2lsbCBiZSBNaWNyb3NvZnQgSHlwZXJ2aXNv
ciBkZWZpbmVkIChhbmQgdGh1cyB3b24ndCBiZSBhDQo+IHN0YXRpYyBhZGRyZXNzKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpeSA8c3RhbmlzbGF2LmtpbnNidXJz
a2l5QGdtYWlsLmNvbT4NCj4gQ0M6ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5j
b20+DQo+IENDOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiBDQzog
V2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiBDQzogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT4NCj4gQ0M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnPg0KPiBDQzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYyB8ICAg
IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVy
LmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+IGluZGV4IDE4ZGUxZjQz
OWZmZC4uYjBiNWRmNTc2ZTE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5
cGVydl90aW1lci5jDQo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMN
Cj4gQEAgLTM2Nyw5ICszNjcsMTEgQEAgc3RhdGljIHVuaW9uIHsNCj4gIAl1OCByZXNlcnZlZFtQ
QUdFX1NJWkVdOw0KPiAgfSB0c2NfcGcgX19hbGlnbmVkKFBBR0VfU0laRSk7DQo+IA0KPiArc3Rh
dGljIHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKnRzY19wYWdlID0gJnRzY19wZy5wYWdlOw0K
PiArDQo+ICBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkN
Cj4gIHsNCj4gLQlyZXR1cm4gJnRzY19wZy5wYWdlOw0KPiArCXJldHVybiB0c2NfcGFnZTsNCj4g
IH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGh2X2dldF90c2NfcGFnZSk7DQo+IA0KPiBAQCAtNDA3
LDcgKzQwOSw3IEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfaHZfY2xvY2tfdHNjKHN0cnVjdCBjbG9j
a3NvdXJjZSAqYXJnKQ0KPiANCj4gIHN0YXRpYyB2b2lkIHJlc3VtZV9odl9jbG9ja190c2Moc3Ry
dWN0IGNsb2Nrc291cmNlICphcmcpDQo+ICB7DQo+IC0JcGh5c19hZGRyX3QgcGh5c19hZGRyID0g
dmlydF90b19waHlzKCZ0c2NfcGcpOw0KPiArCXBoeXNfYWRkcl90IHBoeXNfYWRkciA9IHZpcnRf
dG9fcGh5cyh0c2NfcGFnZSk7DQo+ICAJdW5pb24gaHZfcmVmZXJlbmNlX3RzY19tc3IgdHNjX21z
cjsNCj4gDQo+ICAJLyogUmUtZW5hYmxlIHRoZSBUU0MgcGFnZSAqLw0KPiANCg0KUmV2aWV3ZWQt
Ynk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KDQo=
