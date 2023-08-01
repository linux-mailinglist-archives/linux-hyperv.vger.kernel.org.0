Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97FB76BD19
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHAS6R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHAS5h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 14:57:37 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020021.outbound.protection.outlook.com [52.101.128.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B91708;
        Tue,  1 Aug 2023 11:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckXEshC+Ln7P6oSaAOFghPAdeSxVpW0rA+UV/A5adAOupkfUi8e7bz+BTsKHaTKKKKkhnSelAvQCsKfCmWQy/VnDliYG4WVOE7MGokLWEUUwR983kpxdCa5Y2C2RnPTYwvf9fVpIfN1Q1ugJ6fHLfaSNDQjSatY7wnVIVKOSUW4Fv2von+UuYzG1cZ/45dVVNbNR35AlEPjy8CtO/JX2lVbTIR+xKb6Dig5GLAIQO/M84416Sc1rkOfvHUcw1QyJQbnmLvaTMvihxIFIMxrCLHN8KN4fBUmH1QtyB3lD11xTEY7LxqsxoDuFU8Wla7eNu0v7gOC2ij8YVmjHT5uJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hnFY8jtd3WqXFsRdoAxeRQy3rb7KIGRvWaSckrLyU0=;
 b=EdgbKY8USe1kKITtsFbAsM5t4s1KYlNdl2i5BUvK+M2b/0z5eNFLk02M6cvdsWWUKZR1lakdgNvrjmgge8tetq299QafvhZT5LJGsVgcBmqCZ6G2bRVDIIRP1lOlLnLigU+0CdQjapw/g2g5dAOguN+1SrGjsBQ/Y/kBfr6ICpfZ+YiTjD8yZBh5KZbIsiDsS60kyfhV4DsUCzeNlY1Ga2+rHADzaAIKFlFysHSm6J2EkwXWAes1Cf7inxO8pWrY0/UO19JmAnppVeqpQiX0Hg7k6TgLEc1RHVhxh/+VijjHiTRxoiQIyji7RctJJFhODNwFfqksxtwOJSty0SOpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hnFY8jtd3WqXFsRdoAxeRQy3rb7KIGRvWaSckrLyU0=;
 b=jHAulOyow1cz6+PXtSvN3N+Ot+Y+n22x2grEmuEQD/r+Gpji2WCuWX+3ugQKcqsX7awyfIS+yLMi85RAVOZdbGw5Fo7K/vZaMul2V4rV4Baq4fkxfQr2OMPr+wrJOQo96jDn+Gt6WFxGqjnLd6NjPd04D9cPVQSbCxWt6FmQelA=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SEZP153MB0661.APCP153.PROD.OUTLOOK.COM (2603:1096:101:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.6; Tue, 1 Aug
 2023 18:57:08 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::abe0:95e:5348:dd5a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::abe0:95e:5348:dd5a%4]) with mapi id 15.20.6652.000; Tue, 1 Aug 2023
 18:57:08 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
Thread-Topic: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
Thread-Index: AQHZxHPmLqz8YNs1vkSBwVqcY/Jzsa/VvE8AgAAKo2A=
Date:   Tue, 1 Aug 2023 18:57:07 +0000
Message-ID: <PUZP153MB078824A51D0D9887919E7F1CCC0AA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
 <8ccbfab0-e24f-b758-cd11-27b6d8ab1d48@intel.com>
In-Reply-To: <8ccbfab0-e24f-b758-cd11-27b6d8ab1d48@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aff8f19f-aec5-4a43-a016-968125802f94;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-01T18:42:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SEZP153MB0661:EE_
x-ms-office365-filtering-correlation-id: f0db77df-bcfa-4606-453f-08db92c11a4b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwVyl3+F+TH+ED8O93NYJwT2xdLajo9DXgCgQmsgAHSINULxAyj6FQuqyetgjIGRS4YLk6g3l0jM0tcTlNh1kjB+/SqJtMlEr6hnuGZJTvaZyZl4OPnCbIQRGUtyweFIrE5ZK1jCznLw1k0GZ46RN0KUawg6Lb0OjcpRFxVvaVFseZ8CyaieE9pSeQsN55Biprg430ZG1MdhHjasFAYdWRi0CwwH1T3A5TxEr8A+tYX/miI6TCGomgx9mPqZNrrSBdSTHtRCQBUJWt09dgZpOO33mMHdklRYwlKmdkrzOJrkqAVDYYB4vXN2blFksVKuhGis2/Bmp7qVgeQ30C1cc6SD1WuhxsE3jaj9Mm6UQrtMCK/g9tXKNCgBOFrksUA7tF6XVjbxJ6tgo38BSgIRQmJGyJLRVwCAeN8HpN3UozMuRiRTV8CN9tPUYv9kFR+bfkyv97TREmrA42JYF7I2hDNBSMSKi0EriLJXyBZqFNnetAkxUSDNjyl+2GDmXPRKBUgS/CUhDW1VuoCL9WIxqVBJKS7tBTGn6V2V3XvYpBEIhNNrAvdX4iFdgJOB5qnFVetmUHu28awRLKoxbBbqJcBWg8WFWUPVDVmkH6ti+PL4Z131UhfquKozzt+JnSyPnC1ROWyIt61j4t7h0vlc4Ja6dodzNepzVMzuBmoFY6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(66946007)(10290500003)(66556008)(66446008)(4326008)(6636002)(64756008)(786003)(66476007)(316002)(71200400001)(76116006)(38070700005)(41300700001)(122000001)(54906003)(33656002)(7696005)(9686003)(110136005)(478600001)(8676002)(8936002)(7416002)(52536014)(5660300002)(66899021)(82960400001)(55016003)(82950400001)(6506007)(86362001)(83380400001)(26005)(186003)(2906002)(8990500004)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzNJNTE0V2kvK1AvNFBPbXpUUzJWYnpVd0xkanVnQ0ZtVXZWRGZSU2VnRVRN?=
 =?utf-8?B?MWVJQWNDYmQyQWtIekJHR2kyM0JpTGtETUVOQWp1ODlLQ21vTDZXVzJHUmpj?=
 =?utf-8?B?bzdQQys3c01FYmRJSWRJMjI5TGFISHQxWGt6d3VZbmxuNzdrV0FxTk9PWElG?=
 =?utf-8?B?ZnhvTlNrcFFySDlMRUhWODAycUlJaTB0Yi9mMmhha203WlZPcHV5eUNIRkVI?=
 =?utf-8?B?Ni9GeHhldk1WRVdIc3BwdVN0NXE2RVdrbk04T1hsSy9wOWtqWXN6ZytleHZj?=
 =?utf-8?B?ZDNkbmFzNDVsQmFIc0p5eC9neGpKdDFmSlhUNUxlYUJ2UVlPRjdwd2xoSkoz?=
 =?utf-8?B?QmhwQnU0RTBENU11b3NFWVNFSXpYK0NCSk9vVnFybFBFRmM3eGV3UkNCaTVP?=
 =?utf-8?B?NFZRUkc2NktLcnpzZjVXbS9BZUZ3L25jcmdzTW10dWVQbVQzU1NNa1dqQmJZ?=
 =?utf-8?B?WVVXZGtvK3Bsd2owM1NYSkZPRjd4eStUR1RVTjF6UVhDMng4bUF4V3lmRGVw?=
 =?utf-8?B?QUxwZWpTSHFxT1lwYTJJUHZhMzlQN1RxZ1djVnRIR1RKQnp5cEQ0d0RXUGFG?=
 =?utf-8?B?UnRrWFc3YTBzRHd4bFkxTTliT2g2VGRtVGpNUzVzVDZtdEVWK2VEeU55NkxT?=
 =?utf-8?B?WkIySk1qSUtzeDkvcHNpbFJmZHZyRDR2TFhjcy84Q2lMMGw5QXh6UHgwN2JN?=
 =?utf-8?B?aGV0VzR5Mmg0a1hTSDZrRS9iOE1YZlQ0Q3ZCM0NIVTM0b0RJK1dQS1BjbTBW?=
 =?utf-8?B?NXNtRVlCb3NOMUZRdVladjJEbVNZRTVXTW5BS2lqNStaaVJySDdtMmh2STB2?=
 =?utf-8?B?WFVXKzlKYWptNGdpSmF6MXlQUWJsajRLaUd0SVVZMlUvTVQ0UzdjQ3hVbjVD?=
 =?utf-8?B?MFZWbk9BblVIZHBOd2ZjM3lJaEhLZUVrUzdOc2xIaklaTktqT0RHQjh2QjNt?=
 =?utf-8?B?ajZjYTMxSkp4dzdkSlJaeE55cmYyY3VxZkZGZno0ejluK2RLeE96UzhiRlVH?=
 =?utf-8?B?KzAvMlYzQ0YrVGtNTXV5RkIxcXZJU2h6QzhWUVpUM3B2TkxzUEpEbUNJZWp3?=
 =?utf-8?B?WFlIMjM4NjUvZGxBeEd1Q3Zsem5VcWVXclp1MHBrRkdQUHM0ZUdid1lMRmtD?=
 =?utf-8?B?UWx4YWR0VHIrQ28yZVNUM29PaUg5RmFOajkwVWpJaDVuSEdINWpOdmE1VVI0?=
 =?utf-8?B?cE81Qjlzd1dvUFZrdW9VdW1TL2pWK1lLRGFWbVdLQ2ptMERGdWw4cjY3aVJi?=
 =?utf-8?B?TlViV1g3UHdSMkdwZVlWcXFkTzd4SUx0c1ExODFEZVBkQ3ZvV3ZPeFJmakto?=
 =?utf-8?B?dTgwY1RubXFBbFl6MklNeEE1dU0wNlZxYkNVN0RDbnFEM2h6RDdFRm5PZ0R2?=
 =?utf-8?B?LzlheEFrWk9hcE9tRVM0Nm9pd1dyYUhlTk4yckdqZU9CZ01LVnl4WVRqNHBK?=
 =?utf-8?B?T0trU2F6Y1ltTEl6aWVqRFl4TWhKUTNVS2p3M0hMemVlUlJxY0xJUnRuK2Nx?=
 =?utf-8?B?M0RLZTZCcWdld3lrMDBrMVA5Z09UZkdDbFRPWTltNGR0a2xtVVR0VGVEM0dr?=
 =?utf-8?B?UEpGUmR2SGEzVko0UGlaVTJmSlY5WWo3L0ZCcUErMUVQS1M4Vk5sZ21HWXRy?=
 =?utf-8?B?SGFoTVgwai95bHNwemVsWU02ZFpWWlE2NmtOK0JaWXFVKzJ4dmd3UkozTHlS?=
 =?utf-8?B?azJOR0xFQkl4NWxJMVFXaGhYd0FFczJyS2w2aFJNNDUxbWluTldxNmd5cDVL?=
 =?utf-8?B?c1pLbVNob0laZk54UTBpSTZPRmxqQ25hRWhPODVXdGE4N1kwV1VLYUNTazhS?=
 =?utf-8?B?cURzNTVPbG15RHNlNisyZGRFODlmWjBOU3ZYYXF2cUxlTUIzYktlSGduYU9N?=
 =?utf-8?B?Z01tQjlrcnQwc0hNM3pPOFpxRXNndkw3TjRUWFJPcWo0ZTZXOEtXeG1SSEV1?=
 =?utf-8?B?MVR2SXBaQ2k4Q3hISWNkRGJxRDhxOW5rYUdwY0tWaWxETVVXL2FsOHM1ajdX?=
 =?utf-8?B?V05laDVpUHlMWGwvV0RpUFhLdFZiZ1lrWkZCNE1COWMycS9CNWl6eUpGOHRs?=
 =?utf-8?Q?pEBWAg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0db77df-bcfa-4606-453f-08db92c11a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:57:07.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGEOSZeIBXpZz506HS6aTuy5JIyUE5M8ffPjQhYCVv5xopf/ESFtJxGtQZmw23O7KH2yiFLWPsFt32qzFYF1OGDuQp8+ILOwxR+U9ce6Jsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEplc3NlIEJyYW5kZWJ1cmcg
PGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxLCAy
MDIzIDExOjM0IFBNDQo+VG86IFNvdXJhZGVlcCBDaGFrcmFiYXJ0aSA8c2NoYWtyYWJhcnRpQGxp
bnV4Lm1pY3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuDQo+PGt5c0BtaWNyb3NvZnQuY29tPjsg
SGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47DQo+d2VpLmxpdUBrZXJuZWwu
b3JnOyBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsNCj5kYXZlbUBkYXZlbWxvZnQu
bmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+cGFiZW5pQHJlZGhh
dC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgQWpheSBTaGFybWENCj48c2hh
cm1hYWpheUBtaWNyb3NvZnQuY29tPjsgbGVvbkBrZXJuZWwub3JnOyBjYWkuaHVvcWluZ0BsaW51
eC5kZXY7DQo+c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tOyB2a3V6bmV0cyA8dmt1em5ldHNA
cmVkaGF0LmNvbT47DQo+dGdseEBsaW51dHJvbml4LmRlOyBsaW51eC1oeXBlcnZAdmdlci5rZXJu
ZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+Q2M6IFNvdXJhZGVlcCBDaGFrcmFi
YXJ0aSA8c2NoYWtyYWJhcnRpQG1pY3Jvc29mdC5jb20+Ow0KPnN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggVjcgbmV0XSBuZXQ6IG1hbmE6IEZp
eCBNQU5BIFZGIHVubG9hZCB3aGVuDQo+aGFyZHdhcmUgaXMNCj4NCj5PbiA4LzEvMjAyMyA1OjI5
IEFNLCBTb3VyYWRlZXAgQ2hha3JhYmFydGkgd3JvdGU6DQo+PiBXaGVuIHVubG9hZGluZyB0aGUg
TUFOQSBkcml2ZXIsIG1hbmFfZGVhbGxvY19xdWV1ZXMoKSB3YWl0cyBmb3IgdGhlDQo+PiBNQU5B
IGhhcmR3YXJlIHRvIGNvbXBsZXRlIGFueSBpbmZsaWdodCBwYWNrZXRzIGFuZCBzZXQgdGhlIHBl
bmRpbmcNCj4+IHNlbmQgY291bnQgdG8gemVyby4gQnV0IGlmIHRoZSBoYXJkd2FyZSBoYXMgZmFp
bGVkLA0KPj4gbWFuYV9kZWFsbG9jX3F1ZXVlcygpIGNvdWxkIHdhaXQgZm9yZXZlci4NCj4+DQo+
PiBGaXggdGhpcyBieSBhZGRpbmcgYSB0aW1lb3V0IHRvIHRoZSB3YWl0LiBTZXQgdGhlIHRpbWVv
dXQgdG8gMTIwDQo+PiBzZWNvbmRzLA0KPg0KPnR4IHRpbWVvdXQgaW4gc3RhY2sgZGVmYXVsdHMg
dG8gNSBzZWNvbmRzLCBkbyB5b3Ugbm90IGhhdmUgdGhhdCBvbj8gV2hhdA0KPmhhcHBlbnMgd2hl
biB5b3Ugc3RhcnQgZ2V0dGluZyByZXNldHMgd2hpbGUgdW5sb2FkaW5nPw0KPg0KPj4gd2hpY2gg
aXMgYSBzb21ld2hhdCBhcmJpdHJhcnkgdmFsdWUgdGhhdCBpcyBtb3JlIHRoYW4gbG9uZyBlbm91
Z2ggZm9yDQo+PiBmdW5jdGlvbmFsIGhhcmR3YXJlIHRvIGNvbXBsZXRlIGFueSBzZW5kcy4NCj4N
Cj5JJ2Qgc2F5IDIgb3IgNSBzZWNvbmRzIGlzIHByb2JhYmx5IHBsZW50eSBvZiB0aW1lIHRvIGhh
bmcgdXAgYSBkcml2ZXIgdW5sb2FkLg0KPg0KVGhhbmsgeW91IGZvciB0aGUgY29tbWVudC4gVGhp
cyB3YXMgYWxyZWFkeSBkaXNjdXNzZWQgaW4gVjQuDQpJIGFtIGp1c3Qgc2hhcmluZyB0aGUgc3Vt
bWFyeSBoZXJlOg0KVGhpcyB3YWl0aW5nIHRpbWUgaXMgdXN1YWxseSBtdWNoIHNob3J0ZXIgdGhh
biAxMjAgc2VjLiANClRoZSBsb25nIHdhaXQgb25seSBoYXBwZW5zIGluIHJhcmUgYW5kIHVuZXhw
ZWN0ZWQgTklDIEhXIG5vbi1yZXNwb25kaW5nIGNhc2VzLiANCkF0IHRoYXQgcG9pbnQsIHdlIGRv
bid0IGFjdHVhbGx5IGNhcmUgaWYgdGhlIHBlbmRpbmcgcGFja2V0cyBhcmUgc2VudCBvciBub3Qu
IA0KQnV0IGlmIHdlIGZyZWUgdGhlIHF1ZXVlcyB0b28gc29vbiwgYW5kIHRoZSBIVyBpcyBzbG93
IGZvciB1bmV4cGVjdGVkIHJlYXNvbnMsIA0KYSBkZWxheWVkIGNvbXBsZXRpb24gbm90aWNlIHdp
bGwgRE1BIGludG8gdGhlIGZyZWVkIG1lbW9yeSBhbmQgY2F1c2UgY29ycnVwdGlvbi4gDQpUaGF0
J3Mgd2h5IHdlIGhhdmUgYSBsb25nZXIgd2FpdGluZyB0aW1lLiANCj4+DQo+PiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPj4gRml4ZXM6IGNhOWM1NGQyZDZhNSAoIm5ldDogbWFuYTogQWRk
IGEgZHJpdmVyIGZvciBNaWNyb3NvZnQgQXp1cmUNCj4+IE5ldHdvcmsgQWRhcHRlciAoTUFOQSki
KQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNvdXJhZGVlcCBDaGFrcmFiYXJ0aQ0KPj4gPHNjaGFr
cmFiYXJ0aUBsaW51eC5taWNyb3NvZnQuY29tPg0KPg0KPmtlZXAgcy1vLWIgYW5kIG90aGVyIHRy
YWlsZXJzIHRvZ2V0aGVyIHBsZWFzZSwgbm8gc3BhY2VzLCBpdCBtZXNzZXMgdXAgZ2l0IGFuZA0K
PmRvZXNuJ3QgY29uZm9ybSB0byBrZXJuZWwgc3RhbmRhcmRzLg0KPg0KPg0KPj4gLS0tDQo+PiBW
NiAtPiBWNzoNCj4+ICogT3B0aW1pemVkIHRoZSB3aGlsZSBsb29wIGZvciBmcmVlaW5nIHNrYi4N
Cj4+DQo+PiBWNSAtPiBWNjoNCj4+ICogQWRkZWQgcGNpZV9mbHIgdG8gcmVzZXQgdGhlIHBjaSBh
ZnRlciB0aW1lb3V0Lg0KPj4gKiBGaXhlZCB0aGUgcG9zaXRpb24gb2YgY2hhbmdlbG9nLg0KPj4g
KiBSZW1vdmVkIHVudXNlZCB2YXJpYWJsZSBsaWtlIGNxLg0KPj4NCj4+IFY0IC0+IFY1Og0KPj4g
KiBBZGRlZCBmaXhlcyB0YWcNCj4+ICogQ2hhbmdlZCB0aGUgdXNsZWVwX3JhbmdlIGZyb20gc3Rh
dGljIHRvIGluY3JlbWVudGFsIHZhbHVlLg0KPj4gKiBJbml0aWFsaXplZCB0aW1lb3V0IGluIHRo
ZSBiZWdpbmluZy4NCj4+DQo+PiBWMyAtPiBWNDoNCj4+ICogUmVtb3ZlZCB0aGUgdW5uZWNlc3Nh
cnkgYnJhY2VzIGZyb20gbWFuYV9kZWFsbG9jX3F1ZXVlcygpLg0KPj4NCj4+IFYyIC0+IFYzOg0K
Pj4gKiBSZW1vdmVkIHRoZSB1bm5lY2Vzc2FyeSBicmFjZXMgZnJvbSBtYW5hX2RlYWxsb2NfcXVl
dWVzKCkuDQo+Pg0KPj4gVjEgLT4gVjI6DQo+PiAqIEFkZGVkIG5ldCBicmFuY2gNCj4+ICogUmVt
b3ZlZCB0aGUgdHlwZWNhc3RpbmcgdG8gKHN0cnVjdCBtYW5hX2NvbnRleHQqKSBvZiB2b2lkIHBv
aW50ZXINCj4+ICogUmVwb3NpdGlvbmVkIHRpbWVvdXQgdmFyaWFibGUgaW4gbWFuYV9kZWFsbG9j
X3F1ZXVlcygpDQo+PiAqIFJlcG9zaXRpb25lZCB2Zl91bmxvYWRfdGltZW91dCBpbiBtYW5hX2Nv
bnRleHQgc3RydWN0LCB0byB1dGlsaXNlDQo+PiB0aGUNCj4+ICA2IGJ5dGVzIGhvbGUNCj4+IC0t
LQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYyB8IDM3
DQo+PiArKysrKysrKysrKysrKysrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4+IGluZGV4IGE0OTllNDYwNTk0Yi4uM2M1NTUy
YTE3NmQwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21h
bmEvbWFuYV9lbi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFu
YS9tYW5hX2VuLmMNCj4+IEBAIC04LDYgKzgsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9ldGh0
b29sLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L2ZpbHRlci5oPg0KPj4gICNpbmNsdWRlIDxsaW51
eC9tbS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4+DQo+PiAgI2luY2x1ZGUgPG5l
dC9jaGVja3N1bS5oPg0KPj4gICNpbmNsdWRlIDxuZXQvaXA2X2NoZWNrc3VtLmg+DQo+PiBAQCAt
MjM0NSw5ICsyMzQ2LDEyIEBAIGludCBtYW5hX2F0dGFjaChzdHJ1Y3QgbmV0X2RldmljZSAqbmRl
dikNCj4+IHN0YXRpYyBpbnQgbWFuYV9kZWFsbG9jX3F1ZXVlcyhzdHJ1Y3QgbmV0X2RldmljZSAq
bmRldikgIHsNCj4+ICAJc3RydWN0IG1hbmFfcG9ydF9jb250ZXh0ICphcGMgPSBuZXRkZXZfcHJp
dihuZGV2KTsNCj4+ICsJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArIDEyMCAqIEha
Ow0KPj4gIAlzdHJ1Y3QgZ2RtYV9kZXYgKmdkID0gYXBjLT5hYy0+Z2RtYV9kZXY7DQo+PiAgCXN0
cnVjdCBtYW5hX3R4cSAqdHhxOw0KPj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPj4gIAlpbnQg
aSwgZXJyOw0KPj4gKwl1MzIgdHNsZWVwOw0KPj4NCj4+ICAJaWYgKGFwYy0+cG9ydF9pc191cCkN
Cj4+ICAJCXJldHVybiAtRUlOVkFMOw0KPj4gQEAgLTIzNjMsMTUgKzIzNjcsNDAgQEAgc3RhdGlj
IGludCBtYW5hX2RlYWxsb2NfcXVldWVzKHN0cnVjdA0KPm5ldF9kZXZpY2UgKm5kZXYpDQo+PiAg
CSAqIHRvIGZhbHNlLCBidXQgaXQgZG9lc24ndCBtYXR0ZXIgc2luY2UgbWFuYV9zdGFydF94bWl0
KCkgZHJvcHMgYW55DQo+PiAgCSAqIG5ldyBwYWNrZXRzIGR1ZSB0byBhcGMtPnBvcnRfaXNfdXAg
YmVpbmcgZmFsc2UuDQo+PiAgCSAqDQo+PiAtCSAqIERyYWluIGFsbCB0aGUgaW4tZmxpZ2h0IFRY
IHBhY2tldHMNCj4+ICsJICogRHJhaW4gYWxsIHRoZSBpbi1mbGlnaHQgVFggcGFja2V0cy4NCj4+
ICsJICogQSB0aW1lb3V0IG9mIDEyMCBzZWNvbmRzIGZvciBhbGwgdGhlIHF1ZXVlcyBpcyB1c2Vk
Lg0KPj4gKwkgKiBUaGlzIHdpbGwgYnJlYWsgdGhlIHdoaWxlIGxvb3Agd2hlbiBoL3cgaXMgbm90
IHJlc3BvbmRpbmcuDQo+PiArCSAqIFRoaXMgdmFsdWUgb2YgMTIwIGhhcyBiZWVuIGRlY2lkZWQg
aGVyZSBjb25zaWRlcmluZyBtYXgNCj4+ICsJICogbnVtYmVyIG9mIHF1ZXVlcy4NCj4+ICAJICov
DQo+PiArDQo+PiAgCWZvciAoaSA9IDA7IGkgPCBhcGMtPm51bV9xdWV1ZXM7IGkrKykgew0KPj4g
IAkJdHhxID0gJmFwYy0+dHhfcXBbaV0udHhxOw0KPj4gLQ0KPj4gLQkJd2hpbGUgKGF0b21pY19y
ZWFkKCZ0eHEtPnBlbmRpbmdfc2VuZHMpID4gMCkNCj4+IC0JCQl1c2xlZXBfcmFuZ2UoMTAwMCwg
MjAwMCk7DQo+PiArCQl0c2xlZXAgPSAxMDAwOw0KPj4gKwkJd2hpbGUgKGF0b21pY19yZWFkKCZ0
eHEtPnBlbmRpbmdfc2VuZHMpID4gMCAmJg0KPj4gKwkJICAgICAgIHRpbWVfYmVmb3JlKGppZmZp
ZXMsIHRpbWVvdXQpKSB7DQo+PiArCQkJdXNsZWVwX3JhbmdlKHRzbGVlcCwgdHNsZWVwICsgMTAw
MCk7DQo+PiArCQkJdHNsZWVwIDw8PSAxOw0KPj4gKwkJfQ0KPj4gKwkJaWYgKGF0b21pY19yZWFk
KCZ0eHEtPnBlbmRpbmdfc2VuZHMpKSB7DQo+PiArCQkJZXJyID0gcGNpZV9mbHIodG9fcGNpX2Rl
dihnZC0+Z2RtYV9jb250ZXh0LT5kZXYpKTsNCj4+ICsJCQlpZiAoZXJyKSB7DQo+PiArCQkJCW5l
dGRldl9lcnIobmRldiwgImZsciBmYWlsZWQgJWQgd2l0aCAlZCBwa3RzDQo+cGVuZGluZyBpbiB0
eHEgJXVcbiIsDQo+PiArCQkJCQkgICBlcnIsIGF0b21pY19yZWFkKCZ0eHEtDQo+PnBlbmRpbmdf
c2VuZHMpLA0KPj4gKwkJCQkJICAgdHhxLT5nZG1hX3R4cV9pZCk7DQo+PiArCQkJfQ0KPj4gKwkJ
CWJyZWFrOw0KPj4gKwkJfQ0KPj4gIAl9DQo+Pg0KPj4gKwlmb3IgKGkgPSAwOyBpIDwgYXBjLT5u
dW1fcXVldWVzOyBpKyspIHsNCj4+ICsJCXR4cSA9ICZhcGMtPnR4X3FwW2ldLnR4cTsNCj4+ICsJ
CXdoaWxlIChza2IgPSBza2JfZGVxdWV1ZSgmdHhxLT5wZW5kaW5nX3NrYnMpKSB7DQo+PiArCQkJ
bWFuYV91bm1hcF9za2Ioc2tiLCBhcGMpOw0KPj4gKwkJCWRldl9jb25zdW1lX3NrYl9hbnkoc2ti
KTsNCj4NCj5kZXZfa2ZyZWVfc2tiX2FueSgpIHdvdWxkIGJlIG1vcmUgY29ycmVjdCBoZXJlIHNp
bmNlIHRoaXMgaXMgYW4gZXJyb3IgcGF0aCBhbmQNCj50aGUgdHJhbnNtaXQgaXMgcHJlc3VtZWQg
ZHJvcHBlZCwgaXNuJ3QgaXQ/DQpZZXMsIGRldl9rZnJlZV9za2JfYW55KCkgd2lsbCBiZSBhIGJl
dHRlciBhcHByb2FjaCBpbiB0aGlzIHNjZW5hcmlvLiBXaWxsIGNoYW5nZSBpdCBpbiBuZXh0IHZl
cnNpb24uDQo+DQo+DQo+PiArCQl9DQo+PiArCQlhdG9taWNfc2V0KCZ0eHEtPnBlbmRpbmdfc2Vu
ZHMsIDApOw0KPj4gKwl9DQo+PiAgCS8qIFdlJ3JlIDEwMCUgc3VyZSB0aGUgcXVldWVzIGNhbiBu
byBsb25nZXIgYmUgd29rZW4gdXAsIGJlY2F1c2UNCj4+ICAJICogd2UncmUgc3VyZSBub3cgbWFu
YV9wb2xsX3R4X2NxKCkgY2FuJ3QgYmUgcnVubmluZy4NCj4+ICAJICovDQoNCg==
