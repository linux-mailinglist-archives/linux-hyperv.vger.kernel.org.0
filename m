Return-Path: <linux-hyperv+bounces-512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D47C452C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 01:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D600281E89
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4446432C7B;
	Tue, 10 Oct 2023 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cGmhP0xv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEF354E8;
	Tue, 10 Oct 2023 22:59:58 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F99D;
	Tue, 10 Oct 2023 15:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyBQkGg1osgjoHfy1fQDgvqLLK/zYfk7k3U9i+iKiHfzhTrKe+ljSy4ssg6f83IlsK6F3qDDI+PnxArbsHiu2hX+6ZPivS5yx8yyaVLbBK7AJA4p5SRZe0lJfj6IAXuYGhPmFfiIER0ZMJV9aSK4BYjQK0Bok+XQz/rZGy7d17tH9yEZaYvmHZiM0BcN2vnJaA3zPvVZead6ZqKHT9fiqwgb79jWv6WPRfXRqPzBB1DqHelGSjBsGxTXewXnPEkcf/g5yMS66B2cN8P8/jfmAZPix3oSLhHpZSSkHobvbhgxKs7y/hzt1LSeTsIqxfxT/9uFi1A165SVKRKs41UUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG1wrcYV+FugtlnJ5t2WuJdzziGL5mNzg5UCIsV+JII=;
 b=SqHaI25bhGf8nCsdkG08kZcn+GmaK6ngZxN9DKVGcZq3nZ5cbdmWEPJV4fwbO/PXhq688CLvb44yxTIWR0vu5skiqHRQU8Dt0smeoBCnVQyFnVFE9AX5G2cFRepo8D/5IgwOAm5ovbUBXgmbI9mnPKv1tntKQW45Z7k1YJSiDUOAgtKAjl4Bg18FgbFyxfMj+DJ9EzbAkd6lQSsd4Hrg5QsKCQYZXkn+n/saQaiYxwTzibeKV4bSDWsAhMXY8J6Nj9/1yTh6u57iC5swA6aOFwgfBgKZyzF8KJ7vQvTUIIqIAl1c7AJQaE4dR1HPrRH4uivGFlmqqBADaII+wfZG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG1wrcYV+FugtlnJ5t2WuJdzziGL5mNzg5UCIsV+JII=;
 b=cGmhP0xvXArEuUG1F5xYnDDHy8RUWVWFzKi5D1WIoWQMke2i+A9zFaNKY569nr+qhoK3ZqafmWZx7etx00XrFJbzH30+aIVVt3VucacA8/4QXH/vG58HLEc7OG13gsP2fcJhUNf3GXm+CZVOOaUu42MIgZZBseIKoY5xcOmA9as=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SA0PR21MB1995.namprd21.prod.outlook.com (2603:10b6:806:e5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.5; Tue, 10 Oct
 2023 22:59:50 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0%4]) with mapi id 15.20.6907.003; Tue, 10 Oct 2023
 22:59:50 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Yuchung Cheng <ycheng@google.com>, Stephen Hemminger
	<stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "morleyd@google.com" <morleyd@google.com>,
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, "mubashirq@google.com"
	<mubashirq@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "weiwan@google.com" <weiwan@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Topic: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Index: AQHZ+69YvRb6AGIE90C77PuAO4ZvjLBDlskAgAADo4CAAAYaoA==
Date: Tue, 10 Oct 2023 22:59:49 +0000
Message-ID:
 <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <20231010151404.3f7faa87@hermes.local>
 <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
In-Reply-To:
 <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8862c3e6-e547-4c47-892c-bd0af48f5846;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-10T22:48:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SA0PR21MB1995:EE_
x-ms-office365-filtering-correlation-id: b558209b-75fc-4030-396b-08dbc9e49b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oUMJhrSxGOrwBVk1tAGU5vYWv+Kd6c0L10GS0j6T9YLQITZ5sT4U68dsVtXWGEI0lNE5I4/HSVqgyjfKnE+ry+55kReplKbdXzZ7fKJeFiVAmTrGwMcSEh89vJucglv8CwLJ76AbrnvjbjNWdBU2/m1EZw2JioIbsKPrg67EloNZfNkuk9F+kqQObIuGxF82DSHmTvFpBqq6Qjqx5PTDPdNqH5Yp/yc+ZPXwibymV9ClM6o+kbkT7MxYquVREzuUKZ8sgLbzhPEaqUvfMILOX5oUG9Pt845/GVsGuAPl1E8EPEJuDAktl8kiwAlMTgZDsEowoyh7L+VyVbrAsYVG5ZbP3m2q5MCJifR7P6ZHVDfSXbYUMdfnB4P3/FsCLscRGTWCYZqKA8QcgCNwPaCBj39lVpZvsyUXvn6uE4mRZM9UUEPNJjA+5Ysnoct0sbxEWrIP7q2BylPOLfy3gIpr4FXLf9juEDZ+qvBHNODUzDMP/xVIFLtiM77P0iVMtSfjcfmQB9qAFKTnFdfqyqnvAfV9dswFr7+mT2MgCBtgHzOQlDwEHaz7+cT1Xp6FYVhQYCLVsCdKx70AaeSO09s80koenjMwKWHYQcIu0zY1KI8weV4mYVH7V3Y4OIoKPTAd+mDW3C/TEiICpugWrkb6zw8mRcG/qPyb8eHHeHGLllU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(53546011)(9686003)(33656002)(55016003)(86362001)(38100700002)(38070700005)(82960400001)(82950400001)(10290500003)(122000001)(2906002)(83380400001)(7416002)(26005)(6506007)(7696005)(478600001)(71200400001)(4326008)(8676002)(52536014)(41300700001)(8936002)(8990500004)(66946007)(66556008)(76116006)(54906003)(66476007)(316002)(66446008)(64756008)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K09Eb1ZwOTNTdDNveng5eVNkMjdaTU1Hb295QnN6b2gwREdudVNnZkM4TjBv?=
 =?utf-8?B?Vlp3VncvOXRJaUtYdkFrQjRXRExxdHlNVG52Y2QrQWVrK0dOUTFpdkdWY1Bj?=
 =?utf-8?B?UlFlTXV3dTRtbXRUdHFpdE9URzFITEE2ZUZQbVY3aWtVNVRRVDlrRGRydXZl?=
 =?utf-8?B?a0pweUN4TWt1aXg5ajVPN0U4NzV3eCtsckZaWTFmcVVkK1dmZ2c3QUtsTkxR?=
 =?utf-8?B?dEpwRVZ5NDlHd3ZYR1RtNUpXR3JKZlJ3K1E4aGZhY3Z1T0xKTWFlR3JidjRT?=
 =?utf-8?B?dmQ4NkR2YXd5cU02N2w1Qmh2YXV1WHlteVYrL3VnakNtaDM0SUsyTDNaMTZE?=
 =?utf-8?B?cmQ5cEVuQUlHb1VRdUd3d2xhdVlscGxzS1JpRFZ3Qjg5VlZNenRPN0FkQjll?=
 =?utf-8?B?bXpUanREMDdwYUpHVG9QU3RHSFRRWDN5L1A0b0Q0U0xoMSt5blR4V2wvTWFQ?=
 =?utf-8?B?ME9PUURIbTJpQ1RmbW5jV2pIMFN3VzN4S29lOUg1Q2I0TUtsVmRKNW1samE1?=
 =?utf-8?B?Y25ZWENXV2FjNjBTMS9RYTlER1hWVGxMdmxsaDh6NFhRZ21zdXRObVc3T2Rm?=
 =?utf-8?B?dlorOXJTWUZZUWtWSjFVbmc4SEVZdTRpQkRDYXZaQ3ZjTlZML3FvVWtHL2lp?=
 =?utf-8?B?dVdNNWxvL2VZTlhIeGNleFdVUE9mbGl4amx1K1Vyb3JSTEhaMXNPWjM3MDlH?=
 =?utf-8?B?OGpxQjVjRGFNblQ0bEVIVVNCVW1TV0lCVTlZc0RxVkRZQnhpZUZvd3BBOWZZ?=
 =?utf-8?B?bU4xQTZYUXJvSjBRMW5jOW1Od1l0bjNkQmFZOGxQd002NFFlZk5zVmFmSE8v?=
 =?utf-8?B?bnFWMEdFWkI3eE9qNk5PQXFRZk1WT3hiWXEzNk5XTE9GVGZNRjQ3c0pTbmtE?=
 =?utf-8?B?UVdETGx4TmRPWGVHamZzSk1NOXNLTjZnbzRDdWhXaWRoSnpPeTZSRms2TGZN?=
 =?utf-8?B?NTM3UnJ5cVRPaWcrVXJFSmw3YnVlZWp6MUs4THZPUnlSV3J1VHN4VC9xTTlh?=
 =?utf-8?B?UXhZZWZ0aHMvcnVJTUI4WEd3MmJXc281YXdXSmlZMGhwQ2ZBQzBDek1vcU96?=
 =?utf-8?B?WUxlNzBnNU1aOWFTUkwyeFRTQWNYSVBoV2kweW9OdVc1L2Vnb2Fnc2huSDU4?=
 =?utf-8?B?YjdqbG54Q0o4cTBpTkJRNE1sVzBaamxzWGgrQ0loWXlWZDFBS3U5MVBoZzZV?=
 =?utf-8?B?dGg2VVkvalVoQ3AzTjRYeEgzaE54V1JnQnFkTDFsdlpuZXp2MWQzRlh4MFFz?=
 =?utf-8?B?OWFiMEdEdjNZUlQ5Z0Nob1E5N2FYaUppTjlvWjNDcEExUWFaVlFCbXlIdklh?=
 =?utf-8?B?b0EvYUZ4eUFubjg3Z2dYRkk0enNkcmtndE5aS1A3bGI4RWxBLysvZmZVckd6?=
 =?utf-8?B?Vkl3dDhReTRJSXFRQlRmb3hxN0xZcEdGc01waGoyRHdtZkFYQW03VWlIQmgx?=
 =?utf-8?B?aDhKVnJiZm5HM3VYYUtrWURWZGpWenNaV3h2N2RKWjJwYXc4L2JjcURjbFpT?=
 =?utf-8?B?VmQrSi94N2t5c3g4U0VEcExLNXh3dVV2aXZpemlMeHpwYTN4Rk9SNFUxTWhR?=
 =?utf-8?B?NGZhZ0hwZFVCZmdiYTBOV09nN29kdjJjRXQ1L3EzMU14UHFxYmw2YWxpV3Zl?=
 =?utf-8?B?YnNZd2NubXI2Yis5SXJTcWZSSTdLWS9BRGF6Szk2T2tlWHZrRGc0ZG52UmND?=
 =?utf-8?B?cExCQVhQZ1pFWWFGbkFMVldzN3hqTEkxQk5HRXFIRkFJNHMrWVhYa3ZQVEk0?=
 =?utf-8?B?UUlHYXRBYy8rNUhqMHJocEpBMGpmd3lCMFJ2ZC9SSys1UzJhYXpKYWV2eTNh?=
 =?utf-8?B?dXhnSjA5NnFGdld0QytDZUlrV05WSmkwem0zZGRnR2xLRFMrTUx6bE4zSkpj?=
 =?utf-8?B?VWI5UExLU0NVQlppUTNQaXc4bXpVOSt4WjZuR2cyb3BXQzNFc0ppaWJ3S3Vq?=
 =?utf-8?B?eSs5Y0Y4L2Q1MVAzMEI1Z01qYWtrZVJtNE52SEdHN1NZdXllT0hDeFJ6enRh?=
 =?utf-8?B?cXBxMXFVb3dhTGw2WTBVVGFkcEhrUURoZlp5TkxtZUl4ZmFKV3hmeUcvbzkw?=
 =?utf-8?B?L2JRZmZqMWwxRjJqbmpyNHRJeHB1TDNrd2Y4YXhrK0U3NkQ0dGNHWEYxZFpr?=
 =?utf-8?Q?4OjcyPoupEblMvTNWjIHyFJ/Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b558209b-75fc-4030-396b-08dbc9e49b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 22:59:49.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UOXt1Gf012/BWw4l5j33sg0ySU2sLn1+SV4zHNmYGAjjbNKeKhUKuiVwZgWuejmSLvHEeeTagMPAJ2FmnnuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1995
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXVjaHVuZyBDaGVuZyA8
eWNoZW5nQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgNjoy
NyBQTQ0KPiBUbzogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3Jn
Pg0KPiBDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWh5
cGVydkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtZIFNyaW5p
dmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgY29y
YmV0QGx3bi5uZXQ7IGRzYWhlcm5Aa2VybmVsLm9yZzsNCj4gbmNhcmR3ZWxsQGdvb2dsZS5jb207
IGt1bml5dUBhbWF6b24uY29tOyBtb3JsZXlkQGdvb2dsZS5jb207DQo+IG1mcmVlbW9uQGNsb3Vk
ZmxhcmUuY29tOyBtdWJhc2hpcnFAZ29vZ2xlLmNvbTsgbGludXgtDQo+IGRvY0B2Z2VyLmtlcm5l
bC5vcmc7IHdlaXdhbkBnb29nbGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQsdjJdIHRjcDogU2V0IHBpbmdwb25nIHRocmVz
aG9sZCB2aWEgc3lzY3RsDQo+IA0KPiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCAzOjE04oCvUE0g
U3RlcGhlbiBIZW1taW5nZXINCj4gPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPiB3cm90ZToN
Cj4gPg0KPiA+IE9uIFR1ZSwgMTAgT2N0IDIwMjMgMTI6MjM6MzAgLTA3MDANCj4gPiBIYWl5YW5n
IFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gVENQIHBp
bmdwb25nIHRocmVzaG9sZCBpcyAxIGJ5IGRlZmF1bHQuIEJ1dCBzb21lIGFwcGxpY2F0aW9ucywg
bGlrZSBTUUwgREINCj4gPiA+IG1heSBwcmVmZXIgYSBoaWdoZXIgcGluZ3BvbmcgdGhyZXNob2xk
IHRvIGFjdGl2YXRlIGRlbGF5ZWQgYWNrcyBpbiBxdWljaw0KPiA+ID4gYWNrIG1vZGUgZm9yIGJl
dHRlciBwZXJmb3JtYW5jZS4NCj4gPiA+DQo+ID4gPiBUaGUgcGluZ3BvbmcgdGhyZXNob2xkIGFu
ZCByZWxhdGVkIGNvZGUgd2VyZSBjaGFuZ2VkIHRvIDMgaW4gdGhlIHllYXINCj4gPiA+IDIwMTkg
aW46DQo+ID4gPiAgIGNvbW1pdCA0YTQxZjQ1M2JlZGYgKCJ0Y3A6IGNoYW5nZSBwaW5ncG9uZyB0
aHJlc2hvbGQgdG8gMyIpDQo+ID4gPiBBbmQgcmV2ZXJ0ZWQgdG8gMSBpbiB0aGUgeWVhciAyMDIy
IGluOg0KPiA+ID4gICBjb21taXQgNGQ4ZjI0ZWVlZGM1ICgiUmV2ZXJ0ICJ0Y3A6IGNoYW5nZSBw
aW5ncG9uZyB0aHJlc2hvbGQgdG8gMyIiKQ0KPiA+ID4NCj4gPiA+IFRoZXJlIGlzIG5vIHNpbmds
ZSB2YWx1ZSB0aGF0IGZpdHMgYWxsIGFwcGxpY2F0aW9ucy4NCj4gPiA+IEFkZCBuZXQuaXB2NC50
Y3BfcGluZ3BvbmdfdGhyZXNoIHN5c2N0bCB0dW5hYmxlLCBzbyBpdCBjYW4gYmUgdHVuZWQgZm9y
DQo+ID4gPiBvcHRpbWFsIHBlcmZvcm1hbmNlIGJhc2VkIG9uIHRoZSBhcHBsaWNhdGlvbiBuZWVk
cy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gSWYgdGhpcyBhbiBhcHBsaWNhdGlvbiBzcGVjaWZpYyBv
cHRpbWl6YXRpb24sIGl0IHNob3VsZCBiZSBpbiBhIHNvY2tldCBvcHRpb24NCj4gPiByYXRoZXIg
dGhhbiBzeXN0ZW0gd2lkZSB2aWEgc3lzY3RsLg0KPiBJbml0aWFsbHkgSSBoYWQgYSBzaW1pbGFy
IGNvbW1lbnQgYnV0IGxhdGVyIGRlY2lkZWQgYSBzeXNjdGwgY291bGQNCj4gc3RpbGwgYmUgdXNl
ZnVsIGlmDQo+IDEpIHRoZSBlbnRpcmUgaG9zdCAoZS5nLiB2aXJ0dWFsIG1hY2hpbmUpIGlzIGRl
ZGljYXRlZCB0byB0aGF0IGFwcGxpY2F0aW9uDQo+IDIpIHRoYXQgYXBwbGljYXRpb24gaXMgZGlm
ZmljdWx0IHRvIGNoYW5nZQ0KDQpZZXMsIHRoZSBjdXN0b21lciBhY3R1YWxseSB3YW50cyBhIGds
b2JhbCBzZXR0aW5nLiBCdXQgYXMgc3VnZ2VzdGVkIGJ5IE5lYWwsDQpJIGNoYW5nZWQgaXQgdG8g
YmUgcGVyLW5hbWVzcGFjZSB0byBtYXRjaCBvdGhlciBUQ1AgdHVuYWJsZXMuDQoNClRoYW5rcywN
Ci0gSGFpeWFuZw0KDQo=

