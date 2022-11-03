Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB4618A0C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKCU7G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKCU7F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 16:59:05 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022018.outbound.protection.outlook.com [52.101.53.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669513896;
        Thu,  3 Nov 2022 13:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL6acCr2z7njMYJ3jplUi23wmNc9W53xyx5ttvmPjSlUWUGDi2uhC6wDxAKTT/vzOz4vvQ/OrdZsybeNNrNSnLZx8uJSGL2GwuHOyjPlsaRYQHqgFyy1vzEtsuuebDYPkfEBCEQwjSM5RekcK1URa4GHUBlt+usoKeOVVzugEEFiUeRO/dmJSlinyI42cQgtDWdZ6XTn1CAeUfbTGzshqmIn1SmHsgZ3wAywDmuukA0zrxF0NkHaUk+BB+X4bb4lwuVpBaMWIZzWrw2F73PFS2CtT5pJSkVv96C+nRyqR3wSTROW6CtPPxbPVf/7DNO0FThT5lan/w6wwAzH1aGz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upggqzxt2PvfaHN6lVoRqWIqjHi19KWQV+zrvanuxGM=;
 b=UpmE4cZL9DvftJ9rKXqfGzII5kGwJ0E6ZaYE0nL9TEa9mRQBrcYVg6VRn62iUFUrzWr77xpwLBpoobDrVOcjKpYmeEvp4pRXgSFKScaDXsUF74wfBrmetsp71h/D4sQzCffx+ABNmp9mDUBZIn08T8z3clVpUe5sfUBG9tWtYF0ijMmtidjaZhXJ5vTAFvxH3LKCQuEmOB5BTbH13t6qO2XpLe9eapxS0HYg4oNdWCAZ01L5gAmIJyM2Po2FZvbyzJSKYkIgyzVLCAWu/es9BGzigWe6wfhiS6I+QX8BdkUagg1vvpAdMEbg+37+7DKDWAO8ydXulY5Ofi8jGywv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upggqzxt2PvfaHN6lVoRqWIqjHi19KWQV+zrvanuxGM=;
 b=SPy8AwEB6LFKSLjZgq8L3fcib7YzK2mEwqgXP8Qida+XVCyUhhba+58ji8RD/HcodGKoOrd2bO0rf1ULuLKKBFOPzIKHJ6tGUHYOOkPQi73SjxnRZ4eVG4FvZDJvkIbSIAiyK48HuyCKiRTrkqDHUBJtl3KX2ItUzPNKuXs64l8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1879.namprd21.prod.outlook.com (2603:10b6:510:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Thu, 3 Nov
 2022 20:58:52 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 20:58:52 +0000
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
Subject: RE: [PATCH v3 2/4] drivers/clocksource/hyper-v: Introduce TSC PFN
 getter
Thread-Topic: [PATCH v3 2/4] drivers/clocksource/hyper-v: Introduce TSC PFN
 getter
Thread-Index: AQHY763yvxjlGHuQo0+SkMjL+o1MZq4trqoQ
Date:   Thu, 3 Nov 2022 20:58:52 +0000
Message-ID: <BYAPR21MB16888B1054B7889FCEA2C7E7D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749833420.218190.2102763345349472395.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166749833420.218190.2102763345349472395.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b96f139-a0b9-4ad7-9a50-be9ad48509c1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T20:58:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1879:EE_
x-ms-office365-filtering-correlation-id: eb3eaee4-b306-4e22-0d55-08dabdde36b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mmf7dUi6F9erOc81z4cmMWtoFO6GqLoRZYVTUPxa0Z9ftaRlHlRULCiGkwPXQ69mVwU26nFg51hiw4PYILY3QKh+g7IrGLMCJYIpweF5M3XVCPx3boXmTXDYYlTshVxZIfdT+Or6PQsxAiukRIfNWpGuE0XXwW1HLrrwXYNztp19lU7hKzPioPu6ALqWAwBvgLuOQqlr5qW3/dx94G5igVRQXb0eR1SklRyqvfulPpsitG2Fuhfh51YzX5OhyMX0Ar4uxGeMrK0OSny+72Ou6pLAQNAW+/HMY18mLY1c0ltAs28WiJnDwzQsZd77S2ML/HlGt8aEPbdINpWeJ7jJpdqHXXKIIqi8G64BE84O9AtMOrvHY5AbGA8FGbUByHIJ7PQFfZwkwAIDqHh5IS//Di7kMlEsnZgfSkhONPQUfiesqUA6ayMYSDic9v+jxGxvrzqu41YCybUWn1eSaIi0HvIhXMvgtoql0yFluXaNCarB9yo1yEtXRND7aHp5yiZ9gxD5APrvuVfvXyzGdOiLHbHaRncFGnQ5IOXZDzsf2/0/iURbUqmaQMdvhWsKnR4AIaM6fLDNKdQxGRBeyluySl+FcF3nC/w8HT0UZzBLvjcvx70VCeH384ACEUfeVDtSq7esnKnl5E7UoO2kgrXJlsJyi4uNNm/WNAfnMG1slG7gPH5PKeKDDDv132f1bHfkywl65bDaCjyxj7WsupLDGEA+MOUImb4OI78ueXgVeptiW8H7eExoGAhaGAAJzkqXnbAMf7MhraplKm4aZWj3r5jjiu3UDjsZJ2kIagn0J1BKgLmCb8UwFNXOlqABDFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(186003)(9686003)(83380400001)(6506007)(26005)(7696005)(2906002)(122000001)(55016003)(8990500004)(71200400001)(54906003)(10290500003)(316002)(64756008)(478600001)(76116006)(5660300002)(41300700001)(8936002)(66946007)(4326008)(6862004)(8676002)(52536014)(66556008)(66446008)(33656002)(38100700002)(82960400001)(82950400001)(86362001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVIQ0F2dEZ6aEpiMjhxekxoVlpXR1A1RUZnVnlZTnZoK3VDRktxM09oUUJx?=
 =?utf-8?B?cXNXNUFVV0VwME51T0RlbWdjTGtCSzBGVHgzSlBvcTZGdDNTV29PZVdFQWw5?=
 =?utf-8?B?cVlTbWhpQ3A1aGZuT1BtckdSTXN2UTIrTlJhNXRpeHF4SWphbW1SV3FsVTRE?=
 =?utf-8?B?d051QjRMblJTWjlnaEhIYmd6VTV5eFNUU21HTHZlT3hVdTJOeDVyd0VPUW1D?=
 =?utf-8?B?dnQ5dE8wdjV5TGx1M0U3K3g3RjJmdCtVY1JhaDhWTU5CaVlzT3pKQnB3TzU3?=
 =?utf-8?B?a2xZTy9KTnN3Z25rTUhWbzZleEpwTjFxamFEcTc5TTFNY01uSDlZVGYrZmFo?=
 =?utf-8?B?aDhFb3A4dDhzM040N0dKV2RsT2VEaUN0UXl2a3pCcjJLc2wzY0wrMXpqYVVx?=
 =?utf-8?B?Y0djU0M4d1lMZk5veFNjT0xXZE0vL1NqT1FMSEpFMFRtaTRKVFZSOERReGxj?=
 =?utf-8?B?WW9DeVdEbUpTRzloZGJNWWFFNTFDYXNRbUZ1Tk1TazVJQ3dBNUNEemlPMWtu?=
 =?utf-8?B?cTR6MEV4TkpPZU83Vk1PSTg4cllwcjFOY0tpM3QvRlladFFGSk9VTjd3ZytF?=
 =?utf-8?B?Y21sV0RrUUVWSkMwbWhuYUNLc2xiQ3RsaXZnRit1NXMrY1JRNXFKS3EvZ251?=
 =?utf-8?B?cjF2alU2cEJoMlFwajRzbWJLMWlaOEVwa1dYVWFyQ0JIRW9ZdWtCT0FBRUNr?=
 =?utf-8?B?ZE90OTdYTG9Qa1NyR1JralNrUG5jNGIzazNGQ05TSVpqdDd0UHg3N216aVVH?=
 =?utf-8?B?YUFwVDZVYW1neVl0VXQwbG85SWlKdHNYdm10ZWIwbm1MZmJrQTdTekltUVdm?=
 =?utf-8?B?V1IwRHQyVzQ5NzFna1ZoZ3NNNGJralBNM1QzcEpackhYS3VsUFRCM2ZmRnlQ?=
 =?utf-8?B?Qmdnc25TOHFqYmd4L2dvVU5UNEN5aldpZi82eEtvcGRQWEhuRHB2QUtYdlNN?=
 =?utf-8?B?d25EMHdUcG93bzB6TUFwOFppMGNVdU9FTEk5cGR6SFo3NHhCQjVlaElwdjk4?=
 =?utf-8?B?OE0yeERSTnliZkNlN2xvMFFmRkNxaFlGNGNGUC9ZMS9rcUNVd0Y2MGl0dEQw?=
 =?utf-8?B?L2RsUCtnOStJSTZxUG52MDR1czZGc0NPL2NCOUxUdVRRdWRQM2gzUTBlVVI0?=
 =?utf-8?B?SEJORnlVZURjejNYRUtJcXVjb2Q0YTczWHFPVnlWRHlMYUx1SXFuUGs2cmYx?=
 =?utf-8?B?OG15V2UzN0ZISUhkbEFDbXl1WWlKYWVDQ2hqS3U1ZUtYNU5xbFh4alhyTUR4?=
 =?utf-8?B?ZHErcWJWRDYxQ2FnSmRMT05zRmJjV2JwNFRiM2FGdE9QUXdaRjltMkFWLzEz?=
 =?utf-8?B?OVBoNEVFVXlGSVBhUERwUlNYK2FiUDNDUEhvaTB2Zmd5SFQxNjJnYjhQd0Ja?=
 =?utf-8?B?RlA0OFBRMnhOYk9pa00vY1dQNDdWVVVQWHVCWlVzbS8wS3c5dkt4Wkg3dE1v?=
 =?utf-8?B?b2QzSVVvRXFLVXJGRTdFcGdiRGFiMHFkQXFmWFRSMzIxcytrbys3cTcxa3Y0?=
 =?utf-8?B?eE90WVB5eTBzRm5haXZQR1pPR1VLTmE0eUljNUYzQ2dFVTYxZXJMOENKTGVu?=
 =?utf-8?B?NlRqMGlhelVuTGNrSHB1SXJhcWNQSWQyRVV3WXZaUHFuai80TWlQejNGZUsz?=
 =?utf-8?B?R01xd2FHWHgvSjNxbmh5V081QzdaNTcrUWNiMEdHVUo4ZWpMbm90TFZIYk11?=
 =?utf-8?B?NTNubHgyRjZOQndlUk81UXFraS8zU3Qzc25VV1NkdnhqYitpa2NtWjZHQWp5?=
 =?utf-8?B?NXlNS2htN3ZlaFhqRzJhSlpxWXBTbWxIR1hSTTE0UmhDdnE4cW80V2I5bTY0?=
 =?utf-8?B?TkJzdCtCT0NEUjNpTTNGcDB1amwxSUkvTnlYaUFodFMyRHV3SW5SaTJYQ0VM?=
 =?utf-8?B?YVRlNFdyRm85ZEg3RnVlbGNaYkdaYy9hbStqVURvV0pLQ3hEL3hWNFFKd0NV?=
 =?utf-8?B?S2svWHBaQk5TS2lNdjJveWhXei9Qclc1SEtPVGUvd0lVbkQxekdKNEFKZWly?=
 =?utf-8?B?ZWVRUVk1am5YYkVxYmtYa2YxZWFYM3pnR0hMSDhXaDRUTDd0YVRIeUFQTXZy?=
 =?utf-8?B?d0c2T3kyVmRkYkVXd2pGQlIza0EwL0Urd0lVc29jNkw3OElDYmd4QlRuOFhs?=
 =?utf-8?B?bllLK28yVFExbVRreVJBbVduazFVQzVEYXBFdFphMUQrWVlEYktzbjFNdlBr?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3eaee4-b306-4e22-0d55-08dabdde36b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 20:58:52.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6BQJwr0vuRgfhq6DCxj5dECu+4AmImqjovihr2T8/KxuQkd4vH9pdexpuNiAErdnJRVvc9zE5iRd5eho7InZRV8Aa2sXy+dTVX01DVTvT0=
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
LmNvbT4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMsIDIwMjIgMTA6NTkgQU0NCj4gDQo+IEFu
ZCByZXdvcmsgdGhlIGNvZGUgdG8gdXNlIGl0IGluc3RlYWQgb2YgdGhlIHBoeXNpY2FsIGFkZHJl
c3MsIHdoaWNoIGlzbid0DQo+IHJlcXVpcmVkIGJ5IGl0c2VsZi4NCj4gDQo+IFRoaXMgaXMgYSBj
bGVhbnVwIGFuZCBwcmVjdXJzb3IgcGF0Y2ggZm9yIHVwY29taW5nIHN1cHBvcnQgZm9yIFRTQyBw
YWdlDQo+IG1hcHBpbmcgaW50byBNaWNyb3NvZnQgSHlwZXJ2aXNvciByb290IHBhcnRpdGlvbiwg
d2hlcmUgVFNDIFBGTiB3aWxsIGJlDQo+IGRlZmluZWQgYnkgdGhlIGh5cGVydmlzb3IgYW5kIG5v
dCBieSB0aGUga2VybmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJz
a2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBDQzogIksuIFkuIFNyaW5p
dmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6
QG1pY3Jvc29mdC5jb20+DQo+IENDOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+IEND
OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDQzogRGFuaWVsIExlemNhbm8g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENDOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NCj4gQ0M6IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ0M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2Nsb2Nrc291
cmNlL2h5cGVydl90aW1lci5jIHwgICAxNCArKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9o
eXBlcnZfdGltZXIuYw0KPiBpbmRleCBiMGI1ZGY1NzZlMTcuLmI3YWYxOWQwNmI1MSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KPiArKysgYi9kcml2
ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+IEBAIC0zNjgsNiArMzY4LDEyIEBAIHN0
YXRpYyB1bmlvbiB7DQo+ICB9IHRzY19wZyBfX2FsaWduZWQoUEFHRV9TSVpFKTsNCj4gDQo+ICBz
dGF0aWMgc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAqdHNjX3BhZ2UgPSAmdHNjX3BnLnBhZ2U7
DQo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyB0c2NfcGZuOw0KPiArDQo+ICtzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBodl9nZXRfdHNjX3Bmbih2b2lkKQ0KPiArew0KPiArCXJldHVybiB0c2NfcGZuOw0K
PiArfQ0KPiANCj4gIHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKmh2X2dldF90c2NfcGFnZSh2
b2lkKQ0KPiAgew0KPiBAQCAtNDA5LDEzICs0MTUsMTIgQEAgc3RhdGljIHZvaWQgc3VzcGVuZF9o
dl9jbG9ja190c2Moc3RydWN0IGNsb2Nrc291cmNlICphcmcpDQo+IA0KPiAgc3RhdGljIHZvaWQg
cmVzdW1lX2h2X2Nsb2NrX3RzYyhzdHJ1Y3QgY2xvY2tzb3VyY2UgKmFyZykNCj4gIHsNCj4gLQlw
aHlzX2FkZHJfdCBwaHlzX2FkZHIgPSB2aXJ0X3RvX3BoeXModHNjX3BhZ2UpOw0KPiAgCXVuaW9u
IGh2X3JlZmVyZW5jZV90c2NfbXNyIHRzY19tc3I7DQo+IA0KPiAgCS8qIFJlLWVuYWJsZSB0aGUg
VFNDIHBhZ2UgKi8NCj4gIAl0c2NfbXNyLmFzX3VpbnQ2NCA9IGh2X2dldF9yZWdpc3RlcihIVl9S
RUdJU1RFUl9SRUZFUkVOQ0VfVFNDKTsNCj4gIAl0c2NfbXNyLmVuYWJsZSA9IDE7DQo+IC0JdHNj
X21zci5wZm4gPSBIVlBGTl9ET1dOKHBoeXNfYWRkcik7DQo+ICsJdHNjX21zci5wZm4gPSB0c2Nf
cGZuOw0KPiAgCWh2X3NldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDLCB0c2Nf
bXNyLmFzX3VpbnQ2NCk7DQo+ICB9DQo+IA0KPiBAQCAtNDk5LDcgKzUwNCw2IEBAIHN0YXRpYyBf
X2Fsd2F5c19pbmxpbmUgdm9pZCBodl9zZXR1cF9zY2hlZF9jbG9jayh2b2lkDQo+ICpzY2hlZF9j
bG9jaykge30NCj4gIHN0YXRpYyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJjZSh2
b2lkKQ0KPiAgew0KPiAgCXVuaW9uIGh2X3JlZmVyZW5jZV90c2NfbXNyIHRzY19tc3I7DQo+IC0J
cGh5c19hZGRyX3QJcGh5c19hZGRyOw0KPiANCj4gIAlpZiAoIShtc19oeXBlcnYuZmVhdHVyZXMg
JiBIVl9NU1JfUkVGRVJFTkNFX1RTQ19BVkFJTEFCTEUpKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+
IEBAIC01MjQsNyArNTI4LDcgQEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nr
c291cmNlKHZvaWQpDQo+ICAJfQ0KPiANCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVyID0g
cmVhZF9odl9jbG9ja190c2M7DQo+IC0JcGh5c19hZGRyID0gdmlydF90b19waHlzKGh2X2dldF90
c2NfcGFnZSgpKTsNCj4gKwl0c2NfcGZuID0gSFZQRk5fRE9XTih2aXJ0X3RvX3BoeXModHNjX3Bh
Z2UpKTsNCj4gDQo+ICAJLyoNCj4gIAkgKiBUaGUgSHlwZXItViBUTEZTIHNwZWNpZmllcyB0byBw
cmVzZXJ2ZSB0aGUgdmFsdWUgb2YgcmVzZXJ2ZWQNCj4gQEAgLTUzNSw3ICs1MzksNyBAQCBzdGF0
aWMgYm9vbCBfX2luaXQgaHZfaW5pdF90c2NfY2xvY2tzb3VyY2Uodm9pZCkNCj4gIAkgKi8NCj4g
IAl0c2NfbXNyLmFzX3VpbnQ2NCA9IGh2X2dldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVO
Q0VfVFNDKTsNCj4gIAl0c2NfbXNyLmVuYWJsZSA9IDE7DQo+IC0JdHNjX21zci5wZm4gPSBIVlBG
Tl9ET1dOKHBoeXNfYWRkcik7DQo+ICsJdHNjX21zci5wZm4gPSB0c2NfcGZuOw0KPiAgCWh2X3Nl
dF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDLCB0c2NfbXNyLmFzX3VpbnQ2NCk7
DQo+IA0KPiAgCWNsb2Nrc291cmNlX3JlZ2lzdGVyX2h6KCZoeXBlcnZfY3NfdHNjLCBOU0VDX1BF
Ul9TRUMvMTAwKTsNCj4gDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlA
bWljcm9zb2Z0LmNvbT4NCg0K
