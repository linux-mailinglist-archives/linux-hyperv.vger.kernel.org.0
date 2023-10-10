Return-Path: <linux-hyperv+bounces-505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3257C4206
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36CD1C20C6A
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B21A18C23;
	Tue, 10 Oct 2023 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Px0IVp7a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A53159F;
	Tue, 10 Oct 2023 21:06:07 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C619E;
	Tue, 10 Oct 2023 14:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fknz8J+V4fBtZ6eghogDRaRqK8wZfpYcu8D8tG1FnUmI31Yfovoid1/E3WcU7Fr7482wifhHLgvCTQBI9+MuRbkoULWFTfk84/1dMlfLj7A+bgi1BZHUn+Asv1G5rx21i0lZo+bZnrinRRuqmkZO7aCZAOqUEvV0P7ngKQdHSvRWdz5eHcOTpB0n+og+U3saTlSrJIUoVfn8VrKxFoMcSFhbJHTYqvEyesmE5ZfSdogd2M/86O4pEHj7WE6XM0E9FMo+jW3Y23OZdI6zLZwny00ZPmphj5eHhXoO/E7FojfTkOyTp+dGP3dwf3+bLeCtzwZMxQ7lhDPSTi4lt/sxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn6+fDI0+sLZxcBGjA5rmo9hg2zthVbycDYansLcjpI=;
 b=ZpJclUorN8Fw2/P9oUW+RAipNxc6VvKfDMLo8d+7gWMYteAHZjAkOICExDezD2QS5/iXzhYz24rU9XtOJqH137TjOZkLk5fZsUmlQrQ3e7tJMlm9uCtUTiyr/5QlHxn8bMVOc+RZAHgW6Oirr2W8yayTK3cvc7AuqPEgpCvGZo8CJP4cu5FFe74xLuwybIkyfhvEsUgE4KpwAgPefiRfOAfe/I0oQ/mTU+09s619BuiYnW60uPG0xlWJf4r66DXphTwVSbbYJGrQeBONW9IACZooH+fQVuZKQqF4rmwBKej0Xy8y+QaSBDF1pNb9yH4lQFor4BS+BZkgGHkchbOjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn6+fDI0+sLZxcBGjA5rmo9hg2zthVbycDYansLcjpI=;
 b=Px0IVp7aPf8PeQ1a5hLb5S/ixJtDQgfidACQ/kRDzYTPuW1N9dxay4EtIXDb/ai4oHcbPloa2capHKo7BswPU7nStX8bogmA6f4Cv+P4fJ5MMFhTTlELukXbweMd3GraDjpQr7MkN4R+magnqnmkrBo9XJrM6cDKKHJP8IcDKq4=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SN6PR2101MB1325.namprd21.prod.outlook.com (2603:10b6:805:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.5; Tue, 10 Oct
 2023 21:05:59 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::36cd:bd05:8d58:e8f0%4]) with mapi id 15.20.6907.003; Tue, 10 Oct 2023
 21:05:59 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Neal Cardwell <ncardwell@google.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"ycheng@google.com" <ycheng@google.com>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "morleyd@google.com" <morleyd@google.com>,
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, "mubashirq@google.com"
	<mubashirq@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "weiwan@google.com" <weiwan@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Topic: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Thread-Index: AQHZ+69YvRb6AGIE90C77PuAO4ZvjLBDc0CAgAAQWFA=
Date: Tue, 10 Oct 2023 21:05:59 +0000
Message-ID:
 <PH7PR21MB31167191822AAFA0E7DD72FFCACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <CADVnQy=tPcP+sRRVwvqober3cmi_3=LukzXC3-YcWudbf1e0HA@mail.gmail.com>
In-Reply-To:
 <CADVnQy=tPcP+sRRVwvqober3cmi_3=LukzXC3-YcWudbf1e0HA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42a9deef-4738-4944-ad3e-be60ee742a68;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-10T21:05:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SN6PR2101MB1325:EE_
x-ms-office365-filtering-correlation-id: ceace983-75b6-4242-8a04-08dbc9d4b417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N/llm/aPFNOJ1E/BINle7wZtP6T94LmxZHPm5oe4r2yXkRcdlpYZ1xwSUGk/h+GbXnG+hSjow+tvKnl7aj/ViMsgkQEsMs2l67U0KauTOLwc6MopukNo11ro/h3InCL/ll0DeQv8hmxjkzv9F4RwLQsUbNRkctXBdVeJlvjLgIsxQlWOz5/1M4q7p6Lnp5Fwn/Ph+SLMPid2yUbklrX1R0R6ecOjz1upqxPbRoo/izBzfYYZuSuOpDSHbkJnJO8TmgS7SeIhJyiFI70/VOkCRYWZ3VQXJXNhWFB0IkouXyS+qkNSN9cmW1vuRuMv6GFrdTsUmLnfgIp5J7Sd7wru2omo3WwFvVnfZO6EpKymxlOgf8gy9vaNsUy6qHzoytRi0LjSS0WOF0wCRlmImafflGGWuSBn/sg0PJMrr7cFkPFTCLj8uCp/78yvMk+XSKAJfzc7xsVr786Ogn2zMDdaCKPQSeC8L/C9fJXxVznfPM40t8tBqoyY1G6Bpnp6G7tGS/E/JoRBE7wyHjpBbCy45N92sDiC2LUCv6oMyS8TddQaVkNX3zswQB6KAenak+0xVdf4ltAG9IcPJwcM28FdKDswVFAwXXJJik9bTZBJpLY4Y7DanPn/1WGEgmACmf7jNDaosJOz+x3ZaSn0DSNMhAmOi3I6VSQgH5EwyD7YWII=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(5660300002)(55016003)(26005)(8990500004)(82950400001)(33656002)(9686003)(82960400001)(122000001)(7416002)(52536014)(38070700005)(316002)(54906003)(8676002)(66946007)(66446008)(64756008)(76116006)(6916009)(66476007)(66556008)(8936002)(41300700001)(71200400001)(53546011)(966005)(2906002)(7696005)(6506007)(4326008)(478600001)(86362001)(10290500003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmdWRWp5cWorS214Q3MycSs0MWpqSVRyd2h1NXdrN3o1U0FQVjhZSExJT0hO?=
 =?utf-8?B?c2xmTUFIYzdpK1BLMitEelRLTTB4amNwTFdNU25lS0FDeXFmdUJaOTRQTVQr?=
 =?utf-8?B?SkxmT1hQaUg0SHBicUhESXdXWFluWW9nbEdweVBJM1EwNGRyU1V2dXUyV1o4?=
 =?utf-8?B?bk41My9qbEFUVjk3c1lWUExmdGNlemRjNS9IVHkvTHdTZU10TXcvNDFjcEpq?=
 =?utf-8?B?WDZDNEdRTkxxekZtcFhxaC9yYUNGaTFjTTJNaUlyeXBoOW9pLzJuZzhiOUhm?=
 =?utf-8?B?SkhzTWZjK1pST2RnckRCZDhPQzA0cWVYcVFqNzVuMWVack9qeHRwT1ZoNytL?=
 =?utf-8?B?dzlTRGplMzBOaDlqZGVBTjZ4YWF2bWpxMGZVMVBlcXlHNDltSWMyd1AvcUZs?=
 =?utf-8?B?bk8yTlRoL2FrMFFJSGZCaEwzT25FRzdEdWJjV2lHaTNKa1VObmIzZmtYSVM5?=
 =?utf-8?B?Q3BvT24wbXh3NWw1cVFQNEdDOEpPdFpvbCsva2VsL3RESjRIR0tsSS8yK3lT?=
 =?utf-8?B?bGQwYnZVT2wxMyt2eVMrTE9ORk1IOVZaVVRFNDUwR3dZSk9vYUhyTDVWVHU4?=
 =?utf-8?B?SHhDbzk5NFM3dVZXTVF1SFVsaHRPVG1QTHJMOWtaSVN4NHVqUVVKZUtOdmti?=
 =?utf-8?B?Nk5pZ0JvWHQxQi9mK2M2S1lPaVVhdHNsRXBEWEYvY1BhQkhPMUJHcUQ5NHVt?=
 =?utf-8?B?NHUyajlTY0VNc1hMYTFRZ043YmRaMjlncjZkclhWVUVYelVlSVpadXNBb2tU?=
 =?utf-8?B?Vjg5Sjc0L1c3dUVPdHI5WEF1TGlRUUF4RitvYUltQlh0UFpreTlzbTJLVzd5?=
 =?utf-8?B?QmFCMUtJQXNyeXRqL2cyRnUyWDVyVnAvbVdldDY4VHlyVGgwNkliQ0hRODli?=
 =?utf-8?B?UHZMV1hRNTAxWUhib0VDK2JZWDkvV0Z6b1FJeEJ3ZUFsak9yU0ZXVVRVNktU?=
 =?utf-8?B?ekx2bytxajVPd3RHSlRhL09wOHlqcnN6Z0tpKzQ4eU52dFJZeE4rRXliczZ0?=
 =?utf-8?B?MDhRVzQzbnBGbEVIMmthT1NQL0Q4RnhqZW9Fa0ZyWllhb2JWSnNWRkhxSUFJ?=
 =?utf-8?B?ZzlFRUV2OFlnRThiMHJNb2w5WUR4MVVGYXY0akpuYk1jc2dEQk45N1ZhUXp0?=
 =?utf-8?B?MmJsZlJMbERhWjBkck1qU3I4K1BPaThndjYxbmVBeFFqU1dFb3VVZlcrbi9a?=
 =?utf-8?B?dHplWjV3am9sSlRSbGNsa3l4ZXZkVitMTlo2eUs0eThheDZOeXVFWWdyRzNw?=
 =?utf-8?B?ZEJ6KzRPVkgycno2ZkFHZ05xUi9pRkdWajZyTmZSUkNXYlByS3VPVzI1bnho?=
 =?utf-8?B?TkVwVnJ3QjVGQ1BKdGQrb2ZXVUdWTnQxTThvR3kyM0FKUTBaMm93L3M1eTRN?=
 =?utf-8?B?Mjdkc1ByVnRaNXlrNjdRRlFacVc5U2J6S1hJYVY3Ymd4bllNV1Vkejh3UVNm?=
 =?utf-8?B?dUwweGR6T2RRc0R3bXNGTUhBV2lmYnNvYTU2WDlTVWJuYitHQVBEd083Mllu?=
 =?utf-8?B?T3BSTE5mU0t3WDZJT3BYQnMyV3NybVNKTjBFbGozdXZJcG1UQWJpWm5SMzhJ?=
 =?utf-8?B?YklDVUN4VW9udVJBdFNjR2hTZlF4QnA5ZEZEZG53QWsxOW1mc1R6VTZQYUdk?=
 =?utf-8?B?emJwMTdjTjAveW1mYzV5ZGk2ZC9FSVlQYW9VYk5MbW4yYVgrNVJRbGw2U0hZ?=
 =?utf-8?B?UHpyUnlDVXBobnZoYS9OdHVZK1hoTzFnaE40c05qUFEwNTdydEViRXhWRW5F?=
 =?utf-8?B?MVlwZVJ5TlBFcElYeFJSSzRwZ1JRQVZtWmhNby9mNmtMYWlRVjIrdWJQcTJL?=
 =?utf-8?B?UHM4QnZGMjhxTGVTS0tJMGRjTW5MK0ZrdWRodXQwSWFpMGFFNmhQS1BmcFdj?=
 =?utf-8?B?TGdRT3d0N0hjcHp3UWR2eHJybVc4SVFaYUVSVGZBOVZ5a09sUk9iZG1jeFVD?=
 =?utf-8?B?MXJ5cjVuVDJ6M0ZWd0piUm5tdEdGUWZuWGhEdGtQV0poYWNVbll1TEVmcXo2?=
 =?utf-8?B?MEdTVFliWTdUSVlTRVJ3OTEvTk4yY2UzYmI4RUE5R1RBTXJpRTQ2cXNlSCs0?=
 =?utf-8?B?aVhVRjdLdktTaHR5aE4zVGdQSUNFSjVhQVZWN2VmM3ZvZFFycDJOZWV2VzJv?=
 =?utf-8?Q?pYvizbcPYnBp1lgFya/ZVpA7X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ceace983-75b6-4242-8a04-08dbc9d4b417
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 21:05:59.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /U3OKhUhgSWRVcLrJDIG7XQ49Ro3Y/lqupP8mCdD3m7Hjdu7qs0kINsKtlmyq+zB+aSoqd+WuGvgc1VBfrfS1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmVhbCBDYXJkd2VsbCA8
bmNhcmR3ZWxsQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMg
NDowNyBQTQ0KPiBUbzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCj4g
Q2M6IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsgY29yYmV0QGx3bi5uZXQ7DQo+IGRzYWhlcm5Aa2VybmVsLm9yZzsgeWNoZW5nQGdvb2ds
ZS5jb207IGt1bml5dUBhbWF6b24uY29tOw0KPiBtb3JsZXlkQGdvb2dsZS5jb207IG1mcmVlbW9u
QGNsb3VkZmxhcmUuY29tOyBtdWJhc2hpcnFAZ29vZ2xlLmNvbTsNCj4gbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZzsgd2Vpd2FuQGdvb2dsZS5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQsdjJdIHRjcDogU2V0IHBpbmdw
b25nIHRocmVzaG9sZCB2aWEgc3lzY3RsDQo+IA0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFp
bCBmcm9tIG5jYXJkd2VsbEBnb29nbGUuY29tLiBMZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4g
DQo+IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDM6MjTigK9QTSBIYWl5YW5nIFpoYW5nIDxoYWl5
YW5nekBtaWNyb3NvZnQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRDUCBwaW5ncG9uZyB0aHJl
c2hvbGQgaXMgMSBieSBkZWZhdWx0LiBCdXQgc29tZSBhcHBsaWNhdGlvbnMsIGxpa2UgU1FMIERC
DQo+ID4gbWF5IHByZWZlciBhIGhpZ2hlciBwaW5ncG9uZyB0aHJlc2hvbGQgdG8gYWN0aXZhdGUg
ZGVsYXllZCBhY2tzIGluIHF1aWNrDQo+ID4gYWNrIG1vZGUgZm9yIGJldHRlciBwZXJmb3JtYW5j
ZS4NCj4gPg0KPiA+IFRoZSBwaW5ncG9uZyB0aHJlc2hvbGQgYW5kIHJlbGF0ZWQgY29kZSB3ZXJl
IGNoYW5nZWQgdG8gMyBpbiB0aGUgeWVhcg0KPiA+IDIwMTkgaW46DQo+ID4gICBjb21taXQgNGE0
MWY0NTNiZWRmICgidGNwOiBjaGFuZ2UgcGluZ3BvbmcgdGhyZXNob2xkIHRvIDMiKQ0KPiA+IEFu
ZCByZXZlcnRlZCB0byAxIGluIHRoZSB5ZWFyIDIwMjIgaW46DQo+ID4gICBjb21taXQgNGQ4ZjI0
ZWVlZGM1ICgiUmV2ZXJ0ICJ0Y3A6IGNoYW5nZSBwaW5ncG9uZyB0aHJlc2hvbGQgdG8gMyIiKQ0K
PiA+DQo+ID4gVGhlcmUgaXMgbm8gc2luZ2xlIHZhbHVlIHRoYXQgZml0cyBhbGwgYXBwbGljYXRp
b25zLg0KPiA+IEFkZCBuZXQuaXB2NC50Y3BfcGluZ3BvbmdfdGhyZXNoIHN5c2N0bCB0dW5hYmxl
LCBzbyBpdCBjYW4gYmUgdHVuZWQgZm9yDQo+ID4gb3B0aW1hbCBwZXJmb3JtYW5jZSBiYXNlZCBv
biB0aGUgYXBwbGljYXRpb24gbmVlZHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl5YW5n
IFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBNYWtlIGl0
IHBlci1uYW1lc2FwY2Ugc2V0dGluZywgYW5kIG90aGVyIHVwZGF0ZXMgc3VnZ2VzdGVkIGJ5IE5l
YWwNCj4gQ2FyZHdlbGwsDQo+ID4gYW5kIEt1bml5dWtpIEl3YXNoaW1hLg0KPiA+DQo+ID4gLS0t
DQo+ID4gIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IHwgIDggKysrKysr
KysNCj4gPiAgaW5jbHVkZS9uZXQvaW5ldF9jb25uZWN0aW9uX3NvY2suaCAgICAgfCAxNiArKysr
KysrKysrKystLS0tDQo+ID4gIGluY2x1ZGUvbmV0L25ldG5zL2lwdjQuaCAgICAgICAgICAgICAg
IHwgIDEgKw0KPiA+ICBuZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQuYyAgICAgICAgICAgICB8ICA4
ICsrKysrKysrDQo+ID4gIG5ldC9pcHY0L3RjcF9pcHY0LmMgICAgICAgICAgICAgICAgICAgIHwg
IDIgKysNCj4gPiAgbmV0L2lwdjQvdGNwX291dHB1dC5jICAgICAgICAgICAgICAgICAgfCAgNCAr
Ky0tDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvaXAtc3lz
Y3RsLnJzdA0KPiBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0DQo+ID4g
aW5kZXggNWJmYTE4Mzc5NjhjLi5jMDMwOGI2NWRjMmYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9uZXR3b3JraW5nL2lwLXN5c2N0bC5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L25ldHdvcmtpbmcvaXAtc3lzY3RsLnJzdA0KPiA+IEBAIC0xMTgzLDYgKzExODMsMTQgQEAgdGNw
X3BsYl9jb25nX3RocmVzaCAtIElOVEVHRVINCj4gPg0KPiA+ICAgICAgICAgRGVmYXVsdDogMTI4
DQo+ID4NCj4gPiArdGNwX3Bpbmdwb25nX3RocmVzaCAtIElOVEVHRVINCj4gPiArICAgICAgIFRD
UCBwaW5ncG9uZyB0aHJlc2hvbGQgaXMgMSBieSBkZWZhdWx0LCBidXQgc29tZSBhcHBsaWNhdGlv
biBtYXkgbmVlZA0KPiBhDQo+ID4gKyAgICAgICBoaWdoZXIgdGhyZXNob2xkIGZvciBvcHRpbWFs
IHBlcmZvcm1hbmNlLg0KPiA+ICsNCj4gPiArICAgICAgIFBvc3NpYmxlIFZhbHVlczogMSAtIDI1
NQ0KPiA+ICsNCj4gPiArICAgICAgIERlZmF1bHQ6IDENCj4gPiArDQo+IA0KPiBJdCB3b3VsZCBi
ZSBnb29kIHRvIGRvY3VtZW50IHdoYXQgdGhlIG1lYW5pbmcgb2YgdGhlIHBhcmFtZXRlciBpcy4N
Cj4gUGVyaGFwcyBjb25zaWRlciBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICdUaGUgbnVtYmVyIG9m
IGVzdGltYXRlZCBkYXRhIHJlcGxpZXMgc2VudCBmb3IgZXN0aW1hdGVkIGluY29taW5nIGRhdGEN
Cj4gcmVxdWVzdHMgdGhhdCBtdXN0IGhhcHBlbiBiZWZvcmUgVENQIGVzdGltYXRlcyB0aGF0IGEg
Y29ubmVjdGlvbiBpcyBhDQo+ICJwaW5nLXBvbmciIChyZXF1ZXN0LXJlc3BvbnNlKSBjb25uZWN0
aW9uIGZvciB3aGljaCBkZWxheWVkDQo+IGFja25vd2xlZGdtZW50cyBjYW4gcHJvdmlkZSBiZW5l
Zml0cy4gVGhpcyB0aHJlc2hvbGQgaXMgMSBieSBkZWZhdWx0LA0KPiBidXQgc29tZSBhcHBsaWNh
dGlvbnMgbWF5IG5lZWQgYSBoaWdoZXIgdGhyZXNob2xkIGZvciBvcHRpbWFsDQo+IHBlcmZvcm1h
bmNlLicNCj4gDQpXaWxsIGRvLg0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg==

