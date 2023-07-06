Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A31749E38
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGFNyn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 09:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGFNym (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 09:54:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2094.outbound.protection.outlook.com [40.107.102.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862271990;
        Thu,  6 Jul 2023 06:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyMkt/t49IDpyUcYW1N5cEbEXnSduHvdp1oKyYeDEnXoPyNmMFWh2Nl+dsa1i7ZYBr+ATACEXKM4F+RfynK6Jca+Cef7SOaWzICIaG7vxlJWk/I11gbZGG7f+K13QP7BKTXTFGlyCYM43iSXSyzm+ClO4Fk3ttPDRQYpNp7t34n8x9c4U50O3xqGX/c7Ei5jakTrlbYmQRtOOSNKyJlpR3rVbDqWRR3/iyawCfMocxOOwdQ1D25rKnTxD5yQkMHewY6dtCKnnHEq/hTN4tD4BiRC29rmuahbVs8RTmG7HlKDjEMUNv58qPJ/emoEmytaBY+68MLEnMcB6gA8t/ZeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W/1j6Yi2FYGJHij6ykNi47dRuJO1kZu0SYBJDE/Pr4=;
 b=eB3w+ncu/HGM12sfPdroRAvVM5Y63QpbMz8gLaynDZQq1iWGnhgmNKf8KXXEgNks37IX7BxvsUpdFp5N+MT0olINxw987P55IY6grpbFPj1yJpJMqjunrEy93uiJ0EcBqdIEghz5+i7kC4GW9T0v6ifiTzFlWwhwW+s6To8nEzdHzezfY/WQ+zWn77qjBEK0Z75Vn0WQcQjc6V728o4MVdQ9R7rClsY8uuO2waBub+NE/ZfWVMqxr9+KV8+SsSgCp1eNbyeKTs0m0478gIAxhgQnagyqRMOzcKBl9iC2njYkCVG8DvM+lOHHug/4MiXfTyXkAAIAt73UXur63xlN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W/1j6Yi2FYGJHij6ykNi47dRuJO1kZu0SYBJDE/Pr4=;
 b=XGHUdmyNwbUYD36JAem9mj75c0rGmGvdj8DLd6gOwXf6fC+t3r/srl7OUnQNOVn6UXsrAcLsaCu9zthHOTeZzGMNI8PcyFsR7aapF6X1q4yezHEoPD9CxxtxuQ6pU4BSoa2KhyXAdG0RuFu16SfMtfTHJEwLsdeyrHZdrm/3Xo8=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DM4PR21MB3323.namprd21.prod.outlook.com (2603:10b6:8:6c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.10; Thu, 6 Jul 2023 13:54:35 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Thu, 6 Jul 2023
 13:54:35 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
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
Thread-Index: AQHZrYtO9uZDC1JBBkmdomCootYeWK+oQRyAgAA0VACAAstrgIABUMeAgAAQOYCAAAFbAIAAAVaAgAAgR4A=
Date:   Thu, 6 Jul 2023 13:54:35 +0000
Message-ID: <PH7PR21MB311670231963DE8661C2F178CA2CA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
 <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
 <PUZP153MB0788C7D2376F3271D77CE826CC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <cd36e39a-ebb9-706a-87c3-2f76de82f7ca@intel.com>
In-Reply-To: <cd36e39a-ebb9-706a-87c3-2f76de82f7ca@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=917cc936-f889-4ec4-97e5-69e59e15287a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T13:44:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DM4PR21MB3323:EE_
x-ms-office365-filtering-correlation-id: bc79bbdc-8d18-4083-f04e-08db7e288836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyjMka0f6qMreXGP3H6po9Fflyo72ZhsLZ5RDFVWLWkUyU4LgB/q8jqRACB/fnM+i1yftzctjT3qA+N19AKaqjbc0nwEDIYHBxUfOwooWqNX4/BaucdWi/dkoW12sMa1mb2rVB+oP51mdoCXUm1EInaosoOcbAtb8thiD/7naB9BlSeASXHm5P4xJ/SnY65W/xkg0qnfiYOurnVStX39RIqYsuTj0/CdKgPM+u6FR/ZyoSLC1Obh14uM/UvCwT747scRzTNWoWcBIdslXghHzm5gMwtKjAm10iHVbR8sfJjZByqZURTgv/3Jili7sRfFTsdiD0zp29FSYRYURElayGIpU8mSS0mYNzI0DoWTEkB5JU2HBzlzdYDMwfQFDj5fq3chDaLFQFVBENiZilUJ2JDytTZjdzrJCFsY1ObqYH/G150em3gQ27gAdqJ4C0X1rHwhTdf1gUCfVb04YckIoFCUxu9Jpkq9AZOKdySv3v2aQSLN35SCAVMexHAOTvVcvG2ZUz8B77lnre2xlX7/zEUATOP8gpdh/2XNFiv/vroPKvihguI9wDt9m2jziboBGd1AxkJkXeqJl0I8oV0IqdZ8tA14/Zl4JhBkBGa0Fev5b/WxkItXA7kCgRY2gT3Fs5pMZQZoI7WspjJEZKTpticw3cTNsYG/BqWkwkEo3JQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(71200400001)(10290500003)(478600001)(7696005)(110136005)(54906003)(9686003)(6506007)(26005)(53546011)(186003)(8990500004)(76116006)(2906002)(41300700001)(316002)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(5660300002)(52536014)(7416002)(8936002)(8676002)(38100700002)(122000001)(82960400001)(82950400001)(33656002)(86362001)(38070700005)(83380400001)(55016003)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdJVjV6NnRoUzNmdW5uYUxOQU9GbFhyRm5SOGxBb1owMW9GblFEOGRPSUUy?=
 =?utf-8?B?aFFZYVhDdUpETXJrWjVLejZlaThSK1kvZEJJWFV5eTc1dVQrZmU0ZjUyUzF0?=
 =?utf-8?B?c1VhajFhZzBrbXV5MTZrTXV1RFFRQTdyZkpwSnowS3hWRFU4Tm85Z01JTVFF?=
 =?utf-8?B?ZWY3Z1dVb2xWbmxFcjUvak9STVJZbGw2VEswRWtnb1J5dUx3ckY3b1Ewa2V5?=
 =?utf-8?B?YThsUk5jK2I4MzNSNU44c1htRUp2QVJDMU5QRGh4WmVqVGRPcGtnREhEeUNL?=
 =?utf-8?B?UzZQeno1Y3VpM1oxQnlySWhJZ1p0Q3hhQ3lzSGdoTm9sRWpKWjBiUjhHUkJ2?=
 =?utf-8?B?cklwYW1VWWd2bnl1dFpNVG9yY2d5ZGFibHEzOG1LVGpzUXl0OHo2cTEyd2Nz?=
 =?utf-8?B?bUxOckdlcFhxbGphMFFweWo3RWVVMnlXSDhCVjd0bnZNMHlGMkEvOXlvdWVL?=
 =?utf-8?B?ZEpFN1FkOFVqSHJpZ2tuZGV6N0x0VkpPY2lpOE5HMVA0S1JScWdXRDE2N3pN?=
 =?utf-8?B?NDh5aVVhS1pidnZ6NUdiZmExQ2w1TFAxWk1BQTFuNDF4VUlJOVlKTkVkTm1p?=
 =?utf-8?B?Ui9OeVpRQVNhTnp3R2w0QXFxWlpwS0JxaEVBYUpYV0VlekUrZy8rY3QvaTdP?=
 =?utf-8?B?NEwwU0pTNWhxMnVLWGFGR0VvWWNkL3RVanNDbEptSWJ5T1pFa0piU2RSbytP?=
 =?utf-8?B?cmxiaTdBS2tyMEFkYUFFTkJjWU5hVURtYU9VOEpKY2R6U2EyY2Z6R1BsRURi?=
 =?utf-8?B?cWptZXcxcWpXMXJia2N4dmZJTEFsak4wZjVqMk5XZURhU0RGRFVmRDdFdTJn?=
 =?utf-8?B?OFo1YlJuRWF3RXdQRnlqTEg5bDEyd3l1dy9TYU5rNWphYXpxbjhhcDQvMGpP?=
 =?utf-8?B?TWp6VnZEeHptb2ZHNEJHaENEWGowVER2Q0JSUHBJRTFKaFUvQ0JERlByeHc0?=
 =?utf-8?B?eDNyc0FsUE1neGZ2czhpMVI2bEMyWFVvRXdyL1l5MExaT0VsaDA0KzE1YXVn?=
 =?utf-8?B?OHMwK3dVWU5jc21OMkQ2NzlPVmsydmplVjZVTjBEWkdCYzVOM1ljd1ovUGhZ?=
 =?utf-8?B?YWlXV08zMTROOFBaNW4vMHZrV0lSWWJKQk5GUWxJSm5vYUVmRHVGZ1hHdzIv?=
 =?utf-8?B?c1JjVHFwK0xZWm4yNi9kaThCRVZsOGIyYWRGaExiY3E1TEJQWkRYaGhDb09M?=
 =?utf-8?B?YmdYVzhvRmkzQWN0WU5uZXFyWU90aGtoS1UyOXdKSnFuUGdVdTE5RkFMRjNh?=
 =?utf-8?B?bFBXalVTQzFaWlhVZjZzSXIrYXp2UnJaMVRLVkRlN3loYnF4RFIyOW8yTlA1?=
 =?utf-8?B?djBQUjU4L2dXL0Q5ODlaUlRpY0daZGliL2M2c2NaNlJ2TnNxSG9adWlRYzZB?=
 =?utf-8?B?NVNiNTJNOXJKOFJKZHBVbEdqbzB3NEZzMHZ3dVUrc0kyVHR1YVVaUkVWczNW?=
 =?utf-8?B?eDVsd3pTMVhNaUptUjhaYjk5WU5jOTg0NUZpdkJncnNiUmJtUTlXQ1dVZWpk?=
 =?utf-8?B?cXlsbnE1VjdBdFhRdGxzSGN3R0FnZElMOGxvV1lFN3JwM3p0Z1QrTys1RUZZ?=
 =?utf-8?B?QzBXVGJ0a2Z6dmpHTGJISHRvN1JsYU80aGlwN0RpVU9kYTFBdTNUSmhUVFRv?=
 =?utf-8?B?TDRmdUNLWXZlZzhKNTNNdGdVbXpVVjVCa2dJTHRWR0hUeUhwd0cwTGZIdUpY?=
 =?utf-8?B?ZDRUTjJCc0c5YTU5U1RZZkJGQmdacFJKRFA3Zy8xN3dCTk1OOGRHcmpyWVB1?=
 =?utf-8?B?WTJSN0w4bEtRWlF2SElMV3ZVL3BWVk9KRjF5YWYyWVlqMXRMY1ZVYUM3Tm8z?=
 =?utf-8?B?Y1J1Yi94bmQ2QWZCanc2UXRhWHJsV1VHSGJobUVJRGNWZ1NGVzlsWUo2TzNk?=
 =?utf-8?B?Wk1RUS9rV1NkV0Z2aU9GMW1EOFZQcGNUZk56RzlIeUQ3VnU0QVc2MmNGaVJZ?=
 =?utf-8?B?TXlXaWo1Z0NucGxoUVczSlIwWks0OTZnRmpwVjAvS052OE5Zc3hJOFd2WWxB?=
 =?utf-8?B?SExnTmYvbVJsK2wxVDErNWJEWWI0aDNCSVdNQmFjZCtxQVExbWI4YmVOYi9z?=
 =?utf-8?B?Rm1teFJuanp1MkpmZnNWSWlyaE5keGEyNDRPSXJuWDVCVU1RblFEY3FmWVo5?=
 =?utf-8?Q?Sf3JngaKqEgyK+qZomZIMhEiL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc79bbdc-8d18-4083-f04e-08db7e288836
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 13:54:35.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJWHz80TWgvmoKTyTY7GvG/ZrWU1O8U7I+WPkccceh1jZRDKFTfloKYknDBNElIHFdGIRdY3Cg7aIuR4RY7U6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIExvYmFr
aW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDYsIDIwMjMgNzo0OSBBTQ0KPiBUbzogU291cmFkZWVwIENoYWtyYWJhcnRpIDxzY2hha3JhYmFy
dGlAbWljcm9zb2Z0LmNvbT47IHNvdXJhZGVlcA0KPiBjaGFrcmFiYXJ0aSA8c2NoYWtyYWJhcnRp
QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IENjOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0
LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyB3ZWkubGl1
QGtlcm5lbC5vcmc7IERleHVhbiBDdWkNCj4gPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBkYXZlbUBk
YXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IEFqYXkNCj4g
U2hhcm1hIDxzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+OyBsZW9uQGtlcm5lbC5vcmc7DQo+IGNh
aS5odW9xaW5nQGxpbnV4LmRldjsgc3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tOyB2a3V6bmV0
c0ByZWRoYXQuY29tOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWh5cGVydkB2Z2VyLmtl
cm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggVjQgbmV0XSBuZXQ6
IG1hbmE6IEZpeCBNQU5BIFZGIHVubG9hZA0KPiB3aGVuIGhvc3QgaXMgdW5yZXNwb25zaXZlDQo+
IA0KPiBGcm9tOiBTb3VyYWRlZXAgQ2hha3JhYmFydGkgPHNjaGFrcmFiYXJ0aUBtaWNyb3NvZnQu
Y29tPg0KPiBEYXRlOiBUaHUsIDYgSnVsIDIwMjMgMTE6NDM6NTggKzAwMDANCj4gDQo+ID4NCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBbGV4YW5kZXIg
TG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNk
YXksIEp1bHkgNiwgMjAyMyA1OjA5IFBNDQo+ID4+IFRvOiBTb3VyYWRlZXAgQ2hha3JhYmFydGkg
PHNjaGFrcmFiYXJ0aUBtaWNyb3NvZnQuY29tPjsgc291cmFkZWVwDQo+ID4+IGNoYWtyYWJhcnRp
IDxzY2hha3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPj4gQ2M6IEtZIFNyaW5pdmFz
YW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZw0KPiA+PiA8aGFpeWFuZ3pAbWlj
cm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aQ0KPiA+PiA8ZGVjdWlA
bWljcm9zb2Z0LmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207
DQo+ID4+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IExvbmcgTGkgPGxvbmds
aUBtaWNyb3NvZnQuY29tPjsNCj4gQWpheQ0KPiA+PiBTaGFybWEgPHNoYXJtYWFqYXlAbWljcm9z
b2Z0LmNvbT47IGxlb25Aa2VybmVsLm9yZzsNCj4gPj4gY2FpLmh1b3FpbmdAbGludXguZGV2OyBz
c2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb207DQo+IHZrdXpuZXRzQHJlZGhhdC5jb207DQo+ID4+
IHRnbHhAbGludXRyb25peC5kZTsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
Pj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBWNCBuZXRdIG5ldDogbWFuYTog
Rml4IE1BTkEgVkYgdW5sb2FkDQo+ID4+IHdoZW4gaG9zdCBpcyB1bnJlc3BvbnNpdmUNCj4gPj4N
Cj4gPj4gRnJvbTogU291cmFkZWVwIENoYWtyYWJhcnRpIDxzY2hha3JhYmFydGlAbWljcm9zb2Z0
LmNvbT4NCj4gPj4gRGF0ZTogVGh1LCA2IEp1bCAyMDIzIDEwOjQxOjAzICswMDAwDQo+ID4+DQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZy
b206IEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiA+
Pj4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA1LCAyMDIzIDg6MDYgUE0NCj4gPj4NCj4gPj4gWy4u
Ll0NCj4gPj4NCj4gPj4+Pj4+IDEyMCBzZWNvbmRzIGJ5IDIgbXNlYyBzdGVwIGlzIDYwMDAwIGl0
ZXJhdGlvbnMsIGJ5IDEgbXNlYyBpcyAxMjAwMDANCj4gPj4+Pj4+IGl0ZXJhdGlvbnMuIEkga25v
dyB1c2xlZXBfcmFuZ2UoKSBvZnRlbiBpcyBtdWNoIGxlc3MgcHJlY2lzZSwgYnV0IHN0aWxsLg0K
PiA+Pj4+Pj4gRG8geW91IHJlYWxseSBuZWVkIHRoYXQgbXVjaCB0aW1lPyBIYXMgdGhpcyBiZWVu
IG1lYXN1cmVkIGR1cmluZw0KPiA+Pj4+Pj4gdGhlIHRlc3RzIHRoYXQgaXQgY2FuIHRha2UgdXAg
dG8gMTIwIHNlY29uZHMgb3IgaXMgaXQganVzdCBzb21lDQo+ID4+Pj4+PiByYW5kb20gdmFsdWUg
dGhhdCAic2hvdWxkIGJlIGVub3VnaCI/DQo+ID4+Pj4+PiBJZiB5b3UgcmVhbGx5IG5lZWQgMTIw
IHNlY29uZHMsIEknZCBzdWdnZXN0IHVzaW5nIGEgdGltZXIgLyBkZWxheWVkDQo+ID4+Pj4+PiB3
b3JrIGluc3RlYWQgb2Ygd2FzdGluZyByZXNvdXJjZXMuDQo+ID4+Pj4+IEhlcmUgdGhlIGludGVu
dCBpcyBub3Qgd2FpdGluZyBmb3IgMTIwIHNlY29uZHMsIHJhdGhlciB0aGFuIGF2b2lkDQo+ID4+
Pj4+IGNvbnRpbnVlIGNoZWNraW5nIHRoZSBwZW5kaW5nX3NlbmRzICBvZiBlYWNoIHR4IHF1ZXVl
cyBmb3IgYW4NCj4gPj4+Pj4gaW5kZWZpbml0ZSB0aW1lLA0KPiA+Pj4+IGJlZm9yZSBmcmVlaW5n
IHNrX2J1ZmZzLg0KPiA+Pj4+PiBUaGUgcGVuZGluZ19zZW5kcyBjYW4gb25seSBnZXQgZGVjcmVh
c2VkIGZvciBhIHR4IHF1ZXVlLCAgaWYNCj4gPj4+Pj4gbWFuYV9wb2xsX3R4X2NxKCkgZ2V0cyBj
YWxsZWQgZm9yIGEgY29tcGxldGlvbiBub3RpZmljYXRpb24gYW5kDQo+ID4+Pj4+IGluY3JlYXNl
ZCBieQ0KPiA+Pj4+IHhtaXQuDQo+ID4+Pj4+DQo+ID4+Pj4+IEluIHRoaXMgcGFydGljdWxhciBi
dWcsIGFwYy0+cG9ydF9pc191cCBpcyBub3Qgc2V0IHRvIGZhbHNlLCBjYXVzaW5nDQo+ID4+Pj4+
IHhtaXQgdG8ga2VlcCBpbmNyZWFzaW5nIHRoZSBwZW5kaW5nX3NlbmRzIGZvciB0aGUgcXVldWUg
YW5kDQo+ID4+Pj4+IG1hbmFfcG9sbF90eF9jcSgpIG5vdCBnZXR0aW5nIGNhbGxlZCBmb3IgdGhl
IHF1ZXVlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJZiB3ZSBzZWUgdGhlIGNvbW1lbnQgaW4gdGhlIGZ1
bmN0aW9uIG1hbmFfZGVhbGxvY19xdWV1ZXMoKSwgaXQNCj4gbWVudGlvbnMNCj4gPj4gaXQgOg0K
PiA+Pj4+Pg0KPiA+Pj4+PiAyMzQ2ICAgICAvKiBObyBwYWNrZXQgY2FuIGJlIHRyYW5zbWl0dGVk
IG5vdyBzaW5jZSBhcGMtPnBvcnRfaXNfdXAgaXMNCj4gZmFsc2UuDQo+ID4+Pj4+IDIzNDcgICAg
ICAqIFRoZXJlIGlzIHN0aWxsIGEgdGlueSBjaGFuY2UgdGhhdCBtYW5hX3BvbGxfdHhfY3EoKSBj
YW4gcmUtDQo+IGVuYWJsZQ0KPiA+Pj4+PiAyMzQ4ICAgICAgKiBhIHR4cSBiZWNhdXNlIGl0IG1h
eSBub3QgdGltZWx5IHNlZSBhcGMtPnBvcnRfaXNfdXAgYmVpbmcNCj4gY2xlYXJlZA0KPiA+Pj4+
PiAyMzQ5ICAgICAgKiB0byBmYWxzZSwgYnV0IGl0IGRvZXNuJ3QgbWF0dGVyIHNpbmNlIG1hbmFf
c3RhcnRfeG1pdCgpIGRyb3BzDQo+IGFueQ0KPiA+Pj4+PiAyMzUwICAgICAgKiBuZXcgcGFja2V0
cyBkdWUgdG8gYXBjLT5wb3J0X2lzX3VwIGJlaW5nIGZhbHNlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBU
aGUgdmFsdWUgMTIwIHNlY29uZHMgaGFzIGJlZW4gZGVjaWRlZCBoZXJlIGJhc2VkIG9uIG1heGlt
dW0NCj4gbnVtYmVyDQo+ID4+Pj4+IG9mIHF1ZXVlcw0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBpcyBx
dWl0ZSBvcHBvc2l0ZSB0byB3aGF0IHlvdSdyZSBzYXlpbmcgYWJvdmUuIEhvdyBzaG91bGQgSQ0K
PiA+Pj4+IGNvbm5lY3QgdGhlc2UNCj4gPj4+PiB0d286DQo+ID4+Pj4NCj4gPj4+PiBIZXJlIHRo
ZSBpbnRlbnQgaXMgbm90IHdhaXRpbmcgZm9yIDEyMCBzZWNvbmRzDQo+ID4+Pj4NCj4gPj4+PiAr
DQo+ID4+Pj4NCj4gPj4+PiBUaGUgdmFsdWUgMTIwIHNlY29uZHMgaGFzIGJlZW4gZGVjaWRlZCBo
ZXJlIGJhc2VkIG9uIG1heGltdW0gbnVtYmVyDQo+ID4+Pj4gb2YgcXVldWVzDQo+ID4+Pj4NCj4g
Pj4+PiA/DQo+ID4+Pj4gQ2FuIGNsZWFuaW5nIHRoZSBUeCBxdWV1ZXMgcmVhbGx5IGxhc3QgZm9y
IDEyMCBzZWNvbmRzPw0KPiA+Pj4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aW1lb3V0cyBu
ZWVkIHRvIGJlIHNlbnNpYmxlIGFuZCBub3QgZ28gdG8NCj4gPj4+PiB0aGUgb3V0ZXIgc3BhY2Uu
IFdoYXQgaXMgdGhlIG1lZGl1bSB2YWx1ZSB5b3UgZ290IGR1cmluZyB0aGUgdGVzdHM/DQo+ID4+
Pj4NCj4gPj4+IEZvciBlYWNoIHF1ZXVlIGVhY2ggdGFrZXMgZmV3IG1pbGxpIHNlY29uZCwgaW4g
YSBub3JtYWwgY29uZGl0aW9uLiBTbw0KPiA+Pj4gYmFzZWQgb24gbWF4aW11bSBudW1iZXIgb2Yg
YWxsb3dlZCBxdWV1ZXMgZm9yIG91ciBoL3cgaXQgd29uJ3QgZ28NCj4gPj4+IGJleW9uZCBhIHNl
Yy4NCj4gPj4+IFRoZSAxMjBzIG9ubHkgaGFwcGVucyByYXJlbHkgZHVyaW5nIHNvbWUgTklDIEhX
IGlzc3VlIC11bmV4cGVjdGVkLg0KPiA+Pj4gU28gdGhpcyB0aW1lb3V0IHdpbGwgb25seSB0cmln
Z2VyIGluIGEgdmVyeSByYXJlIHNjZW5hcmlvLg0KPiA+Pg0KPiA+PiBTbyBzZXQgdGhlIHRpbWVv
dXQgdG8gMiBzZWNvbmRzIGlmIGl0IG1ha2VzIG5vIGRpZmZlcmVuY2U/DQo+ID4gSXQgY2FuIGdv
IG5lYXIgMTIwIHNlY29uZHMgaW4gYSB2ZXJ5IHJhcmUgTUFOQSBoL3cgc2NlbmFyaW8uIFRoYXQg
bm9ybWFsbHkNCj4gd29uJ3QgaGFwcGVuLg0KPiA+IEJ1dCBkdXJpbmcgdGhhdCBzY2VuYXJpbywg
d2UgbWF5IG5lZWQgMTIwIHNlY29uZHMuDQo+IA0KPiBUaGlzIHdhaXRpbmcgbG9vcCBpcyBuZWVk
ZWQgdG8gbGV0IHRoZSBwZW5kaW5nIFR4IHBhY2tldHMgYmUgc2VudC4gSWYNCj4gdGhleSB3ZXJl
bid0IHNlbnQgaW4gMSBzZWNvbmQsIGl0IG1vc3QgbGlrZWx5IG1ha2VzIG5vIHNlbnNlIGFscmVh
ZHkNCj4gd2hldGhlciB0aGV5IHdpbGwgYmUgc2VudCBhdCBhbGwgb3Igbm90IC0tIHRoZSBkZXN0
aW5hdGlvbiBob3N0IHdvbid0DQo+IHdhaXQgZm9yIHRoZW0gZm9yIHNvIGxvbmcuDQo+IFlvdSBz
YXkgdGhhdCBpdCBtYXkgaGFwcGVuIG9ubHkgaW4gY2FzZSBvZiBIVyBpc3N1ZS4gSWYgc28sIEkg
YXNzdW1lIHlvdQ0KPiBuZWVkIHRvIGZpeCBpdCBzb21lIHdheSwgZS5nLiBkbyBhIEhXIHJlc2V0
IG9yIHNvPyBJZiBzbywgd2h5IGJvdGhlcg0KPiB3YWl0aW5nIGZvciBUeCBjb21wbGV0aW9ucyBp
ZiBUeCBpcyBodW5nPyBZb3UgZnJlZSBhbGwgc2ticyBsYXRlciBlaXRoZXINCj4gd2F5LCBzbyB0
aGVyZSBhcmUgbm8gbGVha3MuDQoNCkF0IHRoYXQgcG9pbnQsIHdlIGRvbid0IGFjdHVhbGx5IGNh
cmUgaWYgdGhlIHBlbmRpbmcgcGFja2V0cyBhcmUgc2VudCBvciBub3QuIA0KQnV0IGlmIHdlIGZy
ZWUgdGhlIHF1ZXVlcyB0b28gc29vbiwgYW5kIHRoZSBIVyBpcyBzbG93IGZvciB1bmV4cGVjdGVk
IA0KcmVhc29ucywgYSBkZWxheWVkIGNvbXBsZXRpb24gbm90aWNlIHdpbGwgRE1BIGludG8gdGhl
IGZyZWVkIG1lbW9yeSBhbmQgDQpjYXVzZSBjb3JydXB0aW9uLiBUaGF0J3Mgd2h5IHdlIGhhdmUg
YSBsb25nZXIgd2FpdGluZyB0aW1lLg0KDQpTb3VyYWRlZXAsIHlvdSBtYXkgZG91YmxlIGNoZWNr
IHdpdGggaG9zdG5ldCB0ZWFtIHRvIHNlZSB3aGF0J3MgdGhlIA0KYmVzdCB3YWl0aW5nIHRpbWUg
dG8gZW5zdXJlIG5vIG1vcmUgSFcgYWN0aXZpdGllcy4NCg0KVGhhbmtzLA0KLSBIYWl5YW5nDQoN
Cg==
