Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A5749B09
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjGFLoI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjGFLoG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 07:44:06 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020021.outbound.protection.outlook.com [52.101.128.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F261BD0;
        Thu,  6 Jul 2023 04:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU2p+OBa2jPZgITyq0S32KCN9QrKEkrPhce0wLw252mlhQJi+QrZUYoFZ5w+NjgxkbnP2221MjUszqkqvBu0a31843xdu+ps9/c+9oHxu/51pJNcnFAzVRwj0ZeZfNunKs3Pz6N0kHA2pFgz6Yx0SwRzbjPx6drRU9DSJHcH1fN3QEoBDYzU+aetpFLSUGbQsw9p1UbqZtGdQpYWhBFDQS7G77jGU2Lsb57oVtFNphDqwO78AJQV4S7OA5lCEQGfhpKJy60tlVBHpY4bc7ESRfVtmMWwmibg/AEgN2gqubwoOGyCYhISE/IV6x9G1YHDTJwBfGZ4eJx5Gniyl5Qgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgXO3uY8ZggQk7qruWsWzpoM/Gk1/Mq+n7huK9BpB+g=;
 b=d421wX4/vyEp2XmbnyKKxJcWFB07RRd9OYIjzjpIL130eqNqHjOGCcUl7jkGcK6ywyEB42JlTsiXwb0tHsz1fwOUj2IdIFuepvfDseFYif0d3X+lyN9ieCF9ej2ht9+q6uGsplmEQmL2tneBLDdlFtq5PaiVoDIc4SLfofvK1Vy+DRPDoVVk4T3hvy7GpohP6eJfTdww77FMYg59klji07tZkI6x99jop1+BMWL+D3MpFhvzsx/+jt1JNOEwyFjZ4tyt21Wo6JZyqo3JltaxGDBhNgDWyzIiq4YxuI8ATFO1PttWdkuAaqagYrLg+f6XvPalyFBJD70h3KgxDzyabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgXO3uY8ZggQk7qruWsWzpoM/Gk1/Mq+n7huK9BpB+g=;
 b=RgW3fAZUPwXVFdyG5wkFnW2nTrp4gdb0WvOcbdyx/2tgaQ19tYhlug0R5S8oC7J7SwKgavCZXlxgqV5anoOSxYbV1zvy37KBSMOP0WWgXCnTfQHJVaVHxQJsz4KX5RKZrnKDKqhsGuDWFLmbZOeA9dV7nqFQhP5LHhfsr3+HpPY=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SEZP153MB0743.APCP153.PROD.OUTLOOK.COM (2603:1096:101:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.6; Thu, 6 Jul
 2023 11:43:59 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7%6]) with mapi id 15.20.6588.010; Thu, 6 Jul 2023
 11:43:58 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Topic: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Index: AQHZrYtPYuWMOmYHY0O7H4YU8qW43q+oQRyAgAAkWPCAAttngIABTiXAgAAS24CAAADJgA==
Date:   Thu, 6 Jul 2023 11:43:58 +0000
Message-ID: <PUZP153MB0788C7D2376F3271D77CE826CC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
 <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
In-Reply-To: <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e5ea4c5c-9d00-4b1c-96c9-be76d8be7fa6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T11:41:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SEZP153MB0743:EE_
x-ms-office365-filtering-correlation-id: aca5a6c5-979b-457a-9fa6-08db7e16491c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaFm/PS6YET39LIiH6iXnYJ3MM8JEbKEaO/iRrI0+iwBc5hzBWU2HGwPhH6Wn/FWDT0Rb1KAJP+PzYgAQ4NWpIU1bTq0ELzUYfyTD76e4i/grQ1a6XCX6ZIQA0OxACWexm6BVC4l7F3DgxAV7U3tZ/HRssIwZjPIi2reyopX9PvsRdOeXVXapdrfb+CFEUdMsVvokFcr2ksE8QGayPw3TK0+IgrW2ggfgtWYQLqrSafooZqABIuaCD5z4uKSd9NqECaEwn//UGfohz1QVjD6pDeSUAcgRKNW0q1Ic8wHFm/tIhHie5Wc/uDn25nmQ9JUvgAOKxZ6SoPsIoNYmFGhSL2vgu8GnFyfZRPstOigt3nSUTxtH60fSEtGaijA2tQ5K4d+xTL02rUbCIyWg5T1eLtd62NgCxRHcXyZD2BW+EBcr46OdXKCl6GI/0TB0CEFVWxWxeKgGBQsykaYIUUQ68XrzppPgVuWN+25FuVmyyLUs8nzDx+2FnE8vqe2juzIv1cAiIRp6snqMW5EeFNOzFaEO/As64Sh62lcNRuQWiA7MwA80Apqch0Udq9ODi8ew6h7m9GrqTLVf4zKu7BiD7sLkYUeD0HB4AFwUI0Htjp2sjQTFL9+7gDUbGhTxtRP8oBiVCuJ5HRbO36AgbHdg6bgoV4B5AYiYsC5k3DeO10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(86362001)(33656002)(7416002)(38070700005)(8990500004)(2906002)(66899021)(55016003)(8936002)(83380400001)(186003)(6506007)(9686003)(26005)(66476007)(66946007)(82950400001)(82960400001)(122000001)(7696005)(54906003)(110136005)(478600001)(66446008)(316002)(38100700002)(71200400001)(64756008)(4326008)(8676002)(5660300002)(76116006)(10290500003)(52536014)(41300700001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0tkZXd5R2c3RkhDN3g3bXpHWkllTDZjTlplR01VSzhSZGVBMEZac3VhbVU5?=
 =?utf-8?B?WHMzK0FmMjQ2SjhrRlp2eUVVNUR5elQvTDNqZjlBdzhucENUS3gwWnU4WHRW?=
 =?utf-8?B?R1ZwNVNJNDhIYTZlR3F1NTFSb2tzOGY1MjRQcmNMWC8vSmhpNzM4ZHhaeHdh?=
 =?utf-8?B?NjVTcEh4TTA1MjIrai9oSUtUNTdCZStOdDU2K3V5N2FHKzFQWXJJYS9tc2tI?=
 =?utf-8?B?Qm9kY1FVUkY4aGgxSVdXWnRTaHdrV2J5SUoyTzdRWmcwQUtzYy9ud3F0dDZu?=
 =?utf-8?B?ZXdReEN0RytlckllZHE5dVBkVDdXb2pvbWk5Y1hQRFRuWjVJdmowbVZhVm8r?=
 =?utf-8?B?WnNtbFhtOTNiQmFKSlp3S2YxaEVvVEwyVW1iOFNtdVF0dzMxT2o1MDBseUlo?=
 =?utf-8?B?ME9SbmluaHB5d0twbENDZ2t0TWxrYm1NTzMzYUFZYTg0VktWc2p6Tmh6TVRm?=
 =?utf-8?B?NkRaa1BucVpYY1BCMWFaL1ZIczZiWEVWdG5BUm85YVA5VTE0WFhJdXhDMVdO?=
 =?utf-8?B?RzIzTURJMDBnQXczR0s2UjgrY3hUZ2JaRzdsNUsrNFNGcEJ6dUYxeWZWUjVM?=
 =?utf-8?B?Y21nd2pjQ1NZMUdYbTBuTDB4aHFra0Y1TG00THNYcHhoV0VQbW1XMlZDbmJ3?=
 =?utf-8?B?Qm5na0VOV2xCNVZuQWlaYWVXQkRSbDh0MTRPcXBRRExyajRiOFhyUFRaRTEy?=
 =?utf-8?B?QWk4YjhEWG8xWTFkZWM4NlBaYkxrRkxxbmdqOEUxZXBURFQrV0dwc3FMV0VY?=
 =?utf-8?B?UTNuZU4xL0pzV1V6d0xJaUdac1k0UU8yL3lIRUlxWG9wQjViUmtyL3Vubll0?=
 =?utf-8?B?eE1mYzN0bkY4Z0xlUzR2UFNXcStoMHM1ZjJnL1pRc1lUaVFXM0hOUnlxZlp1?=
 =?utf-8?B?NWRBMW5BZExqb1RtbkdBLzQzcWZMSWc4RXg0Qml5eE9zY2pqQ0FMWWlUeG43?=
 =?utf-8?B?czk4RGdDSm9laTR4Y3pSeHU3Nkd3TmdWS1dxV2wybWcySXo2NGNpU2g4Zmds?=
 =?utf-8?B?bnhUSmxvZ1hKbi9DNm9pWXZLY3h6TmZMeC9LMHd3dmZqeFFGcWx1cDR5K3Ay?=
 =?utf-8?B?TmdwTjlPdk1UK2lvY2QrQ2tocVFiOU50YnZrQXk5ZUdOUTI2S2ZhMTNSZ3BN?=
 =?utf-8?B?aTVwRjB1Z0x2RlcvSGE4OVBJYXE0dERsbWZjdW5tZ095cW81TTVNSk5rY0N5?=
 =?utf-8?B?M2c3SzNvdVdNamowSWtFNEZFdjJBaFBQNG4wWkdRNlFpbFhzRElSdzRNUk0r?=
 =?utf-8?B?KzF3VlFpYWJQdzVoKzJXcXJwVUxUREw0NFhNWDkyZ3NsZndkczFpTStJN1p2?=
 =?utf-8?B?OThOck1wbWwvajIvbTV6eTJEbGgyTndFQWNrQ1RnSjRkNVBhc3RGbEt1YVJl?=
 =?utf-8?B?NnhsdzlNUDlmUkVPaXJYNE5ZZjRGUVYweVhEdVpHTFNkYTBMejJjNEgvY1JJ?=
 =?utf-8?B?Mk9MaEp4aXpKbmNrampEYXhSOEROdDgwREtTUzRjYW9GYW9wcTdtWkdOK1pR?=
 =?utf-8?B?eFl0aHo0QkdRd2NnY0RJRlgxUHk4b2lRMHlkeHoxQmRDN1VVWFZRZkFNVlZx?=
 =?utf-8?B?Mm1LR2kvdGltdHdHOHNkaUxNTm9STTd6V090VXo2WWtzWmEwd3VuUU8wcEIy?=
 =?utf-8?B?UFZzOG5UVExWaksyTVFlWGZ0MGZPZnRqN3JkWEp6WGlNK3pXOSs5UzkyOUdT?=
 =?utf-8?B?TzhBN2hkcXk3bk1kT2xCbmtjT0hxUFNpMjFBOVo4QWZMT1l1NXUzWjVoYWx6?=
 =?utf-8?B?SHUzc0pKb0ZzclYyNFV3cFp1TVgyeEs3UzNUZUorbEsxbldTRVJzWkJOelRC?=
 =?utf-8?B?QTgrbVlQL08yeGt6NWw1S2l6UG5Td0ZnTVFiT2JTV2N0UG9vN1JCVWdWTXV4?=
 =?utf-8?B?cFh6cVA4RlRBMXp5ZHBqUEZzVDVLbXNxYjVjeHFqd0FHZUYwd2JUeGFWTGsz?=
 =?utf-8?B?L0NYeXRpeGRvdERnZjRndVR3a2lMMXh0QmRSd0F4am1MTHNudGVJUTI0dlFC?=
 =?utf-8?B?SnlGRlRJaEFGVzQzVnErZGVEb244TFN6UTIzaUNPTHdBVXptaGxNdTFRUlpr?=
 =?utf-8?Q?rTHBj0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aca5a6c5-979b-457a-9fa6-08db7e16491c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 11:43:58.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzBdifkxluLUsPvydqMfIcuya/023lkzE4Bgx/B90wXICTNXhp8u4RwmZaaKDf8PW3oN3qX/S3iVxl0s+i7qorMp8gcFuHTY3oIrdqcYtLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsZXhhbmRlciBMb2Jha2lu
IDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBKdWx5IDYs
IDIwMjMgNTowOSBQTQ0KPlRvOiBTb3VyYWRlZXAgQ2hha3JhYmFydGkgPHNjaGFrcmFiYXJ0aUBt
aWNyb3NvZnQuY29tPjsgc291cmFkZWVwDQo+Y2hha3JhYmFydGkgPHNjaGFrcmFiYXJ0aUBsaW51
eC5taWNyb3NvZnQuY29tPg0KPkNjOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47
IEhhaXlhbmcgWmhhbmcNCj48aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVs
Lm9yZzsgRGV4dWFuIEN1aQ0KPjxkZWN1aUBtaWNyb3NvZnQuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj5rdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRo
YXQuY29tOyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IEFqYXkNCj5TaGFybWEgPHNo
YXJtYWFqYXlAbWljcm9zb2Z0LmNvbT47IGxlb25Aa2VybmVsLm9yZzsNCj5jYWkuaHVvcWluZ0Bs
aW51eC5kZXY7IHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbTsgdmt1em5ldHNAcmVkaGF0LmNv
bTsNCj50Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggVjQgbmV0XSBuZXQ6IG1hbmE6IEZpeCBNQU5B
IFZGIHVubG9hZA0KPndoZW4gaG9zdCBpcyB1bnJlc3BvbnNpdmUNCj4NCj5Gcm9tOiBTb3VyYWRl
ZXAgQ2hha3JhYmFydGkgPHNjaGFrcmFiYXJ0aUBtaWNyb3NvZnQuY29tPg0KPkRhdGU6IFRodSwg
NiBKdWwgMjAyMyAxMDo0MTowMyArMDAwMA0KPg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jh
a2luQGludGVsLmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyA4OjA2IFBN
DQo+DQo+Wy4uLl0NCj4NCj4+Pj4+IDEyMCBzZWNvbmRzIGJ5IDIgbXNlYyBzdGVwIGlzIDYwMDAw
IGl0ZXJhdGlvbnMsIGJ5IDEgbXNlYyBpcyAxMjAwMDANCj4+Pj4+IGl0ZXJhdGlvbnMuIEkga25v
dyB1c2xlZXBfcmFuZ2UoKSBvZnRlbiBpcyBtdWNoIGxlc3MgcHJlY2lzZSwgYnV0IHN0aWxsLg0K
Pj4+Pj4gRG8geW91IHJlYWxseSBuZWVkIHRoYXQgbXVjaCB0aW1lPyBIYXMgdGhpcyBiZWVuIG1l
YXN1cmVkIGR1cmluZw0KPj4+Pj4gdGhlIHRlc3RzIHRoYXQgaXQgY2FuIHRha2UgdXAgdG8gMTIw
IHNlY29uZHMgb3IgaXMgaXQganVzdCBzb21lDQo+Pj4+PiByYW5kb20gdmFsdWUgdGhhdCAic2hv
dWxkIGJlIGVub3VnaCI/DQo+Pj4+PiBJZiB5b3UgcmVhbGx5IG5lZWQgMTIwIHNlY29uZHMsIEkn
ZCBzdWdnZXN0IHVzaW5nIGEgdGltZXIgLyBkZWxheWVkDQo+Pj4+PiB3b3JrIGluc3RlYWQgb2Yg
d2FzdGluZyByZXNvdXJjZXMuDQo+Pj4+IEhlcmUgdGhlIGludGVudCBpcyBub3Qgd2FpdGluZyBm
b3IgMTIwIHNlY29uZHMsIHJhdGhlciB0aGFuIGF2b2lkDQo+Pj4+IGNvbnRpbnVlIGNoZWNraW5n
IHRoZSBwZW5kaW5nX3NlbmRzICBvZiBlYWNoIHR4IHF1ZXVlcyBmb3IgYW4NCj4+Pj4gaW5kZWZp
bml0ZSB0aW1lLA0KPj4+IGJlZm9yZSBmcmVlaW5nIHNrX2J1ZmZzLg0KPj4+PiBUaGUgcGVuZGlu
Z19zZW5kcyBjYW4gb25seSBnZXQgZGVjcmVhc2VkIGZvciBhIHR4IHF1ZXVlLCAgaWYNCj4+Pj4g
bWFuYV9wb2xsX3R4X2NxKCkgZ2V0cyBjYWxsZWQgZm9yIGEgY29tcGxldGlvbiBub3RpZmljYXRp
b24gYW5kDQo+Pj4+IGluY3JlYXNlZCBieQ0KPj4+IHhtaXQuDQo+Pj4+DQo+Pj4+IEluIHRoaXMg
cGFydGljdWxhciBidWcsIGFwYy0+cG9ydF9pc191cCBpcyBub3Qgc2V0IHRvIGZhbHNlLCBjYXVz
aW5nDQo+Pj4+IHhtaXQgdG8ga2VlcCBpbmNyZWFzaW5nIHRoZSBwZW5kaW5nX3NlbmRzIGZvciB0
aGUgcXVldWUgYW5kDQo+Pj4+IG1hbmFfcG9sbF90eF9jcSgpIG5vdCBnZXR0aW5nIGNhbGxlZCBm
b3IgdGhlIHF1ZXVlLg0KPj4+Pg0KPj4+PiBJZiB3ZSBzZWUgdGhlIGNvbW1lbnQgaW4gdGhlIGZ1
bmN0aW9uIG1hbmFfZGVhbGxvY19xdWV1ZXMoKSwgaXQgbWVudGlvbnMNCj5pdCA6DQo+Pj4+DQo+
Pj4+IDIzNDYgICAgIC8qIE5vIHBhY2tldCBjYW4gYmUgdHJhbnNtaXR0ZWQgbm93IHNpbmNlIGFw
Yy0+cG9ydF9pc191cCBpcyBmYWxzZS4NCj4+Pj4gMjM0NyAgICAgICogVGhlcmUgaXMgc3RpbGwg
YSB0aW55IGNoYW5jZSB0aGF0IG1hbmFfcG9sbF90eF9jcSgpIGNhbiByZS1lbmFibGUNCj4+Pj4g
MjM0OCAgICAgICogYSB0eHEgYmVjYXVzZSBpdCBtYXkgbm90IHRpbWVseSBzZWUgYXBjLT5wb3J0
X2lzX3VwIGJlaW5nIGNsZWFyZWQNCj4+Pj4gMjM0OSAgICAgICogdG8gZmFsc2UsIGJ1dCBpdCBk
b2Vzbid0IG1hdHRlciBzaW5jZSBtYW5hX3N0YXJ0X3htaXQoKSBkcm9wcyBhbnkNCj4+Pj4gMjM1
MCAgICAgICogbmV3IHBhY2tldHMgZHVlIHRvIGFwYy0+cG9ydF9pc191cCBiZWluZyBmYWxzZS4N
Cj4+Pj4NCj4+Pj4gVGhlIHZhbHVlIDEyMCBzZWNvbmRzIGhhcyBiZWVuIGRlY2lkZWQgaGVyZSBi
YXNlZCBvbiBtYXhpbXVtIG51bWJlcg0KPj4+PiBvZiBxdWV1ZXMNCj4+Pg0KPj4+IFRoaXMgaXMg
cXVpdGUgb3Bwb3NpdGUgdG8gd2hhdCB5b3UncmUgc2F5aW5nIGFib3ZlLiBIb3cgc2hvdWxkIEkN
Cj4+PiBjb25uZWN0IHRoZXNlDQo+Pj4gdHdvOg0KPj4+DQo+Pj4gSGVyZSB0aGUgaW50ZW50IGlz
IG5vdCB3YWl0aW5nIGZvciAxMjAgc2Vjb25kcw0KPj4+DQo+Pj4gKw0KPj4+DQo+Pj4gVGhlIHZh
bHVlIDEyMCBzZWNvbmRzIGhhcyBiZWVuIGRlY2lkZWQgaGVyZSBiYXNlZCBvbiBtYXhpbXVtIG51
bWJlcg0KPj4+IG9mIHF1ZXVlcw0KPj4+DQo+Pj4gPw0KPj4+IENhbiBjbGVhbmluZyB0aGUgVHgg
cXVldWVzIHJlYWxseSBsYXN0IGZvciAxMjAgc2Vjb25kcz8NCj4+PiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgdGltZW91dHMgbmVlZCB0byBiZSBzZW5zaWJsZSBhbmQgbm90IGdvIHRvDQo+Pj4g
dGhlIG91dGVyIHNwYWNlLiBXaGF0IGlzIHRoZSBtZWRpdW0gdmFsdWUgeW91IGdvdCBkdXJpbmcg
dGhlIHRlc3RzPw0KPj4+DQo+PiBGb3IgZWFjaCBxdWV1ZSBlYWNoIHRha2VzIGZldyBtaWxsaSBz
ZWNvbmQsIGluIGEgbm9ybWFsIGNvbmRpdGlvbi4gU28NCj4+IGJhc2VkIG9uIG1heGltdW0gbnVt
YmVyIG9mIGFsbG93ZWQgcXVldWVzIGZvciBvdXIgaC93IGl0IHdvbid0IGdvDQo+PiBiZXlvbmQg
YSBzZWMuDQo+PiBUaGUgMTIwcyBvbmx5IGhhcHBlbnMgcmFyZWx5IGR1cmluZyBzb21lIE5JQyBI
VyBpc3N1ZSAtdW5leHBlY3RlZC4NCj4+IFNvIHRoaXMgdGltZW91dCB3aWxsIG9ubHkgdHJpZ2dl
ciBpbiBhIHZlcnkgcmFyZSBzY2VuYXJpby4NCj4NCj5TbyBzZXQgdGhlIHRpbWVvdXQgdG8gMiBz
ZWNvbmRzIGlmIGl0IG1ha2VzIG5vIGRpZmZlcmVuY2U/DQpJdCBjYW4gZ28gbmVhciAxMjAgc2Vj
b25kcyBpbiBhIHZlcnkgcmFyZSBNQU5BIGgvdyBzY2VuYXJpby4gVGhhdCBub3JtYWxseSB3b24n
dCBoYXBwZW4uDQpCdXQgZHVyaW5nIHRoYXQgc2NlbmFyaW8sIHdlIG1heSBuZWVkIDEyMCBzZWNv
bmRzLg0KPg0KPj4+PiBhcmUgYWxsb3dlZCBpbiB0aGlzIHNwZWNpZmljIGhhcmR3YXJlLCBpdCBp
cyBhIHNhZmUgYXNzdW1wdGlvbi4NCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiArICAgZm9yIChpID0g
MDsgaSA8IGFwYy0+bnVtX3F1ZXVlczsgaSsrKSB7DQo+Pj4+Pj4gKyAgICAgICAgICAgdHhxID0g
JmFwYy0+dHhfcXBbaV0udHhxOw0KPj4+Pj4+ICsgICAgICAgICAgIGNxID0gJmFwYy0+dHhfcXBb
aV0udHhfY3E7DQo+Wy4uLl0NCj4NCj5UaGFua3MsDQo+T2xlaw0K
