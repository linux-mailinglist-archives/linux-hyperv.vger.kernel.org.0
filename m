Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30B4FF298
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Apr 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiDMIuV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Apr 2022 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMIuT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Apr 2022 04:50:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191F3D1CC;
        Wed, 13 Apr 2022 01:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnzK7gbfp8yd0cbu2agpiDK9nStO8o4ZafSUmSHPfT8/lgihTMI0piHIEPq9e3K1GT+aHZFeRaS/QcRi9lK6dldX01X0Yj8qXNQ+n2+0m7IVeM/zB5klpZTq47urYd6UAt6gJ93vlH2pvE3hg8J1b8fA2YD6Anede+ax23AYnl9yk6Wla5W/oLV05A853U9PCHxB4eML/DZXSTEZE0lF98GsT0cpoGdzk4dF0Iau2xs+M9cmV+OugQhl54hHF2as1grrDwDtg4OFU4DTJga91lkGE3M7Fj3Da6Pf7uXZA55nYj5QBZo9LT5JYsBMvurjq6Maesunj4y2qMybrb+d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SnZ73h3NkH7EmCCHfrxd6vyfcSg6G2YNWeQ+D2x62k=;
 b=ktmFFNFF8wD7hSl0JxF7Hia27nkrsp+SbtWssjeZCq95d0dPFErNTn2tf7i1sZcxMDKBGiAEB1dt9uWseaBLbbCGFpmg+LOYBLzNmKznquwESRN/O741rdBXQBbyh3oc+GPNyql4Bftt1rs8KJszTbxF/QlvkSODctayrO9QuS0F3uqPE6vzUDfGq5opKk3ppFKfWA8QdK5GNxo3U7xe7pwjnDWPMsjhH+m+H1m0I0ECMjSwpVu3WIiZG4B83qovF6Yo7Td5tuW9ji2oRjtgX5t9vRb2Na3LI/CrJQHV+OirMFxhUjsrxbd/oXaE8+hv4hUXp3NYFXdeQDchqId0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SnZ73h3NkH7EmCCHfrxd6vyfcSg6G2YNWeQ+D2x62k=;
 b=toKEdMCdTtV+x5Hl7+F/xl3v3HIpXjH1H3D17qxHuzFlEHT3G6i9K1ylp88JyCoskGzc0TYrMc3vfsZt2hdq3PDJ4msfdJXOizi+QzVvATlUaXqP81y5xsu1TGS64ohezRuZ8p0ZZTbKRnFNiygXgaIaJ3+vLPa4hHsZtK0ztXU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6144.jpnprd01.prod.outlook.com (2603:1096:400:4c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 08:47:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 08:47:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Thread-Topic: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Thread-Index: AQHYR4usqrdzUSvyPkWDhxjfW2t+CqzsXZDQgAE3vICAAAEvAA==
Date:   Wed, 13 Apr 2022 08:47:56 +0000
Message-ID: <OS0PR01MB5922F2C8D5B17A614215ED7B86EC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-13-krzysztof.kozlowski@linaro.org>
 <OS0PR01MB59226666C2C6805C86304BE586ED9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f967f1b2-80a2-8418-d5e8-1e2ac41730a6@linaro.org>
In-Reply-To: <f967f1b2-80a2-8418-d5e8-1e2ac41730a6@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d3fc861-a754-44cb-0730-08da1d2a4e63
x-ms-traffictypediagnostic: TYCPR01MB6144:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6144A6D7AB64CE48E12D081386EC9@TYCPR01MB6144.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymTIp51hFv8NOlvKi+2qs4ktqw5eAH+AAhx69UPYYBL7ZsCj+cN/463KKUwfu59g1W7Yamd/OpO1pBZA6IP/CF2X7yKUVWVEUDW5AnKO12gqT5+0fpaharDs0ntFPhtjnCg/NQCOy14la0oQdDo2A1faA4xZeHqtOdIVbKzS7WuaQO7cd6+cWN/rlMIkEh+fh9DI6ouPDI2usytwSLA8FLFfPa7mGGht6hflsPi3p8CwlE+K2JKHLMD0pMr4GJqRR0Gtc+jVSob+IxIP/L3PRVlVG+lLt8+9iYtAs+d9QGdoUcAqu3yzWPuo6UAI+sfYPOW3u+MQYDEcfvVbYKMBY5bN5C0lvAzxlW43KbB0QiccWg3uSWWqetEFr/y0WQXPo25IbTkt/2BsDmneeBLJYwx1oUWchvMxwXWD+63aoNjivhac19KZYrSHja33vYN/3kxLktFQuFLFULS8LDvfchM79tML8jJp4mekqYFwipGM87i2Mz+JHv3rpo3zoUa9Z3d0f0+6xZ4rHkBSMceZ/Vrh8q5D//N2JcxvzFWorJIvNkymGABn5e9iN8UKcLR00sgVd7c5j+zA6R/C0i2ZTpx8svYe28pZuF7xKNbdwQTpbCFXwL4p0FAmqmUAtBhCoQ0vKzdM/5UbTQ1QoID8UlRiG6K7dPaqmcdhRsyV08dmJvzQ6OFbV4aSDmLcVpHjF09tHFevtU6ya5ujXmuBig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(83380400001)(316002)(53546011)(64756008)(66446008)(508600001)(4326008)(8936002)(66556008)(7696005)(66946007)(6506007)(66476007)(76116006)(52536014)(38100700002)(71200400001)(38070700005)(86362001)(9686003)(8676002)(5660300002)(186003)(26005)(110136005)(54906003)(2906002)(33656002)(7416002)(7406005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2xLc25XM1BiNHF3UVQzUEFTNWszb05oWUV6OWdsK2xvcnZwRmZ6cFdOYnJr?=
 =?utf-8?B?bGxuaWlZSEN1L014Vm5yaHRjMDFucmwxaG9qckFITEY1ZU54VW16SytLaUxp?=
 =?utf-8?B?dHg3bktlNHJhSTNMVmxmY1pjOGo0VnhQelJEaFZQTDRyTnkrKzFqQ2gvdS83?=
 =?utf-8?B?N2tpQjBZWWVjcTRjQ1Fta3NGQkZsd3l6Vm40a21IMnhuZEtYQ2JMQzlpeTMw?=
 =?utf-8?B?N1hDSVo4ZjJhVWduZVN1a1FiSFcrWEhqTXU3NUkxZkZnV2svMXVkbGFFLzlO?=
 =?utf-8?B?d2FmVXdzMWs1V3NkMkc4dm52aHh3OWw3YkkrdG5GK0lON0JScnJLdGEreEtN?=
 =?utf-8?B?WkRnMkYyR0pxdnAyYXlJTXBBZ01aenZ1aE1oeUJEYjBLYW9udWkxNHJGZXpr?=
 =?utf-8?B?cTN4OVJuQXgyQ2FSaDZtSmpNQllnZkQ4bmRDUjhLSEsxcUlQRmJoKzBETWtv?=
 =?utf-8?B?UERUTmppa01IakZCMWpsc01CeGZJVVdCbnNlSkRXRmxuamoxLzlyVUhCRVlu?=
 =?utf-8?B?c2wwM2F4MVRBQkhhWWNYT05PclBkajdYdjhhRmJqaDhpbnJBWEpTSmRTZWtJ?=
 =?utf-8?B?aHVydUp0TnRqYytFUmJQbmlhWUgzdmVjUFRyaC9Fa2VhVzd0YUY5N014QzBa?=
 =?utf-8?B?cENqVm5ka05hT0FpN3c1Rll4SktnU3ZNQ25vQSt0YllzZUVZU2habFJnQkxT?=
 =?utf-8?B?THZQS3VaTkpxMGhEZEZBRlpCd1lXYytqK3VZQklGNjhGMVFEUEprQlh3UTV3?=
 =?utf-8?B?NUlzampmbDh4aXZlRjdocE8xc3V0ZHRRV1VLQWpTY2dIQy96T3pvOVlRR3NS?=
 =?utf-8?B?Z2lOajJ6cmE1ZEFPVEVqUGVOcjlDd3hKSVJyV2tpTERobithWGEwWEt1L0sr?=
 =?utf-8?B?L2dCM3JtcmlxalZiaTF1alM1RVFhRjJVTmxwcHRkQjd6N0VoU1J5c2ZYSHFT?=
 =?utf-8?B?eVRIUGxHaVNXK1BOLzRHR0Z2a2NwUDdGMmxBazBNWXg0RnpMSkFRQnV4QkMw?=
 =?utf-8?B?WWRYV25RS1pFbEdWa2J4RC80OGJwTUFIT2RrVE96akJrZDE1MzN1OUc3ZUE5?=
 =?utf-8?B?UHduUm5nd0wzd21LV0ZnZ2hSaGpudDM4UmJpUGVFZ05aaWlxdUVJMTlReUlm?=
 =?utf-8?B?VkdtMHcwRkNXVncvWUVUelhNQ1M4dmdFeXNGVXVtaVJTb1lUaXBRMGFLb0lB?=
 =?utf-8?B?eTNFOWg3MTZIejVSQjhoaVJ0TDZrWXlvdThSTGZSV0ROZjhuYUhTbnJKMFBI?=
 =?utf-8?B?UVNjTElseTNyTEkwYmJGaStKS1R0WGNpZnB1MjlybzBKZDNPTWdTYVRrRWFS?=
 =?utf-8?B?eHZwUWJjSyt1dC9veWJoWjVUdG9QT2VwNmpzaWM2S1I0RTJ5K3p3bjBlcDV2?=
 =?utf-8?B?UTB5cU4vUkFtc3VIY2cyOGExOUcvZk9CbWNSN3g0aVFoR2ZFd1pGbmRESk91?=
 =?utf-8?B?NnV5VkRZaVFWeXo0ZXpqSUtNcXl5emhodzFTdWdBdmp0aTg4Qnd4R3Y3SGFH?=
 =?utf-8?B?Sis2S0xSa0JUdnpNcFBzRVV1M3R1bDNmU05sdnlhdG14cVNzOWhhRVdxS2xh?=
 =?utf-8?B?eC9lVHN5QnRKT09QM2xvVTdIckhEVWVPU2paWGhRVFM0SnBKL2Y0cmJZQVFN?=
 =?utf-8?B?a09XZHNkM0VRQzdvdEwzejB5THJZVmV5ZDNxOERtaFRLWExTS3VmYnF1Y3pO?=
 =?utf-8?B?YXAxakoySFBsalpxUmwrWWpXcitiNU5yeWJ1OEZpNjF2dnVoOGhhZy9nNTRx?=
 =?utf-8?B?ZTlwd2VGQWV6eC85b1FtcExMSXdxYm9ZSnJaTVVUbW1UdGFIeXJUNlJXQnlT?=
 =?utf-8?B?L2tKcWlQSTMxUlNyazJXdDdNOU5MTHJmM2JvaWlRYUxxZGRzNEc0WDZQTnVN?=
 =?utf-8?B?V0xZalUxUnRIUmgzZXVXNlZrYUp4NmREbTI1YlF4ZHJCVHlET2lMV0dWcjBG?=
 =?utf-8?B?dGNFRndiTURGRVlZbCtPNWJGY1lMODBkeVkzS0E1V1lTNDg2Q25MbUE5K0tu?=
 =?utf-8?B?M3dodzZjS2J2M0ppWmRuV01OQXNFNVdDNG1NRFVaOURKM3BwTCtXVWZIVjQ5?=
 =?utf-8?B?M2dkSGV5WFNVMithSzI1WXk5bDR4TjBTWCsvWk9hM3dYT3NFdzV5NHk1OTlr?=
 =?utf-8?B?SlA2WTU5TWZRYk9NdzI1K1M5dm1TblU4MVVpaE5lR3Rva2t4eUROYjV1K0w3?=
 =?utf-8?B?M2NLR0xOMzlXQWtMUkVCcUVlcWsrSHdCSWJiWVFRZXBZT1dyNG4xUVN0U2lh?=
 =?utf-8?B?MGFKdzlqM3ppSi9zTHFITVpKL1hINmFJZnJBNHNjRXlyOGNFQ1ZhVEExdFRW?=
 =?utf-8?B?SHloL1JGM3RhMWg1a0wvSUJCc0lsbVhsdjBTdFBIeXdkMVM0Q3lUdS81VE1j?=
 =?utf-8?Q?b/2qwFk0/4NBE5kM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3fc861-a754-44cb-0730-08da1d2a4e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 08:47:56.6197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfZWI40/duQYZsR/anB+DNkNxnvKkU+lVFNOLtK/4XIbmTWb55rNkpCV7cPQfWqaeI6e0Ic8Pkz2jTwX7eUHQrVZwx3sclpOpyVmWx/eX6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEyLzEy
XSBycG1zZzogRml4IGtmcmVlKCkgb2Ygc3RhdGljIG1lbW9yeSBvbg0KPiBzZXR0aW5nIGRyaXZl
cl9vdmVycmlkZQ0KPiANCj4gT24gMTIvMDQvMjAyMiAxNjoxMCwgQmlqdSBEYXMgd3JvdGU6DQo+
ID4gSGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNo
Lg0KPiA+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2NiAxMi8xMl0gcnBtc2c6IEZpeCBrZnJlZSgp
IG9mIHN0YXRpYyBtZW1vcnkgb24NCj4gPj4gc2V0dGluZyBkcml2ZXJfb3ZlcnJpZGUNCj4gPj4N
Cj4gPj4gVGhlIGRyaXZlcl9vdmVycmlkZSBmaWVsZCBmcm9tIHBsYXRmb3JtIGRyaXZlciBzaG91
bGQgbm90IGJlDQo+ID4+IGluaXRpYWxpemVkIGZyb20gc3RhdGljIG1lbW9yeSAoc3RyaW5nIGxp
dGVyYWwpIGJlY2F1c2UgdGhlIGNvcmUNCj4gPj4gbGF0ZXIga2ZyZWUoKSBpdCwgZm9yIGV4YW1w
bGUgd2hlbiBkcml2ZXJfb3ZlcnJpZGUgaXMgc2V0IHZpYSBzeXNmcy4NCj4gPj4NCj4gPj4gVXNl
IGRlZGljYXRlZCBoZWxwZXIgdG8gc2V0IGRyaXZlcl9vdmVycmlkZSBwcm9wZXJseS4NCj4gPj4N
Cj4gPj4gRml4ZXM6IDk1MGE3Mzg4ZjAyYiAoInJwbXNnOiBUdXJuIG5hbWUgc2VydmljZSBpbnRv
IGEgc3RhbmQgYWxvbmUNCj4gPj4gZHJpdmVyIikNCj4gPj4gRml4ZXM6IGMwY2RjMTlmODRhNCAo
InJwbXNnOiBEcml2ZXIgZm9yIHVzZXIgc3BhY2UgZW5kcG9pbnQNCj4gPj4gaW50ZXJmYWNlIikN
Cj4gPj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxv
d3NraUBsaW5hcm8ub3JnPg0KPiA+PiBSZXZpZXdlZC1ieTogQmpvcm4gQW5kZXJzc29uIDxiam9y
bi5hbmRlcnNzb25AbGluYXJvLm9yZz4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3JwbXNnL3Jw
bXNnX2ludGVybmFsLmggfCAxMyArKysrKysrKysrKy0tDQo+ID4+ICBkcml2ZXJzL3JwbXNnL3Jw
bXNnX25zLmMgICAgICAgfCAxNCArKysrKysrKysrKystLQ0KPiA+PiAgaW5jbHVkZS9saW51eC9y
cG1zZy5oICAgICAgICAgIHwgIDYgKysrKy0tDQo+ID4+ICAzIGZpbGVzIGNoYW5nZWQsIDI3IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3JwbXNnL3JwbXNnX2ludGVybmFsLmgNCj4gPj4gYi9kcml2ZXJzL3JwbXNnL3JwbXNnX2lu
dGVybmFsLmggaW5kZXggZDRiMjNmZDAxOWE4Li4xYTJmYjhlZGY1ZDMNCj4gPj4gMTAwNjQ0DQo+
ID4+IC0tLSBhL2RyaXZlcnMvcnBtc2cvcnBtc2dfaW50ZXJuYWwuaA0KPiA+PiArKysgYi9kcml2
ZXJzL3JwbXNnL3JwbXNnX2ludGVybmFsLmgNCj4gPj4gQEAgLTk0LDEwICs5NCwxOSBAQCBpbnQg
cnBtc2dfcmVsZWFzZV9jaGFubmVsKHN0cnVjdCBycG1zZ19kZXZpY2UNCj4gKnJwZGV2LA0KPiA+
PiAgICovDQo+ID4+ICBzdGF0aWMgaW5saW5lIGludCBycG1zZ19jdHJsZGV2X3JlZ2lzdGVyX2Rl
dmljZShzdHJ1Y3QgcnBtc2dfZGV2aWNlDQo+ID4+ICpycGRldikgIHsNCj4gPj4gKwlpbnQgcmV0
Ow0KPiA+PiArDQo+ID4+ICAJc3RyY3B5KHJwZGV2LT5pZC5uYW1lLCAicnBtc2dfY3RybCIpOw0K
PiA+PiAtCXJwZGV2LT5kcml2ZXJfb3ZlcnJpZGUgPSAicnBtc2dfY3RybCI7DQo+ID4+ICsJcmV0
ID0gZHJpdmVyX3NldF9vdmVycmlkZSgmcnBkZXYtPmRldiwgJnJwZGV2LT5kcml2ZXJfb3ZlcnJp
ZGUsDQo+ID4+ICsJCQkJICAicnBtc2dfY3RybCIsIHN0cmxlbigicnBtc2dfY3RybCIpKTsNCj4g
Pg0KPiA+IElzIGl0IG5vdCBwb3NzaWJsZSB0byB1c2UgcnBkZXYtPmlkLm5hbWUgaW5zdGVhZCBv
ZiAicnBtc2dfY3RybCIgPw0KPiA+IHJwZGV2LT5pZC5uYW1lIGhhcyAicnBtc2dfY3RybCIgZnJv
bSBzdHJjcHkocnBkZXYtPmlkLm5hbWUsDQo+ID4gcnBkZXYtPiJycG1zZ19jdHJsIik7DQo+ID4N
Cj4gPiBTYW1lIGZvciAicnBtc2dfbnMiIGFzIHdlbGwNCj4gDQo+IEl0J3MgcG9zc2libGUuIEkg
a2VwdCB0aGUgcGF0dGVybiBvZiBkdXBsaWNhdGluZyB0aGUgc3RyaW5nIGxpdGVyYWwNCj4gYmVj
YXVzZSBvcmlnaW5hbCBjb2RlIGhhZCBpdCwgYnV0IEkgZG9uJ3QgbWluZCB0byBjaGFuZ2UgaXQu
IEluIHRoZSBvdXRwdXQNCj4gYXNzZW1ibGVyIHRoYXQgbWlnaHQgYmUgYWRkaXRpb25hbCBpbnN0
cnVjdGlvbiAtIG5lZWQgdG8gZGVyZWZlcmVuY2UgdGhlDQo+IHJwZGV2IHBvaW50ZXIgLSBidXQg
dGhhdCBkb2VzIG5vdCBtYXR0ZXIgbXVjaC4NCj4gDQoNCk9LLCBpdCdzIGEgc3VnZ2VzdGlvbiBh
cyBzYW1lIHN0cmluZyBjb25zdGFudCBkdXBsaWNhdGVkIHRocmljZSwNCg0KQW55IGNoYW5nZSBp
biB0aGlzIHN0cmluZyBjb25zdGFudCBpbiBmdXR1cmUgd2lsbCBuZWVkIGNoYW5nZXMNCmluIDMg
cGxhY2VzICwgYnkgdXNpbmcgInJwZGV2LT5pZC5uYW1lIiwgdGhlIGNoYW5nZSBpcyBsaW1pdGVk
DQp0byAxIHBsYWNlLg0KDQpDaGVlcnMsDQpCaWp1DQo=
