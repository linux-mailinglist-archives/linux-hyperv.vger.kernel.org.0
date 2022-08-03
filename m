Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78782589021
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Aug 2022 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiHCQ0P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHCQ0O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 12:26:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAD7679;
        Wed,  3 Aug 2022 09:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6n+53ALr4SrFK+9VTlvlCHEzOVUC6Zgdoj8abI0OzfPJM+LdLTYTZQBcmJsUg6cG7kGvNoEaEe9gxoxhxQK10j6Ib4oDpHFhA/S0g53WXRYMM81Pwxs+HSsNr+0xEa+ImWIO3VQ9sHZ96soGJdLxlPCYA0Qv6ZB+C1jNxJhJwJIAjG3350woUMuDPyCMZUkyzbgmdvZ2fpdjlOumFAmmq+60mHs/lJTh/ELs3UG2iKDub8G/HDM2pSfR84EtcJGGIlX/Vx87OEowFEgs5mudVoP0J2hnN1tov6DZUQKB+TOb/ZwQdKTrsbFuvrNw1ijG+H4YjSm/d6Fb2ssW7JkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhbzTZQ8WnMlQgfXQGEaoKLcndN9DLuBBFEwrzzlQ80=;
 b=Z75sYK4Yc16uA9Lc2oNVcWkHnVKZFzVeVs55TQiMwA6WTKjlz4jjsuMv3GBthnqJjuz4feONRDrq8fvGTP1Tpl77Qiab0QbYqX+kEb4aVHi57A2P0LgopGkUSSEpS6S8Jj6fTuRJhdrjR8707Kz1UM259BnQLPsVhjAeWEhGaATUhh6oH5wbcNNoHs4hXNN10cCjh8lxPGE9nwznWiJuLIESv72L/kMu+SX2ZlpuDC2Zxd8Jnfb6LIqC4z5Tj/joD0u4Red/pSAjZFa9adNfJPI796k8WEmx0YAZHZUZ6ri4i3Ke0CbqIeoEV6vAYaKRjfyIXU/VbLSHy2vZq8Ss8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhbzTZQ8WnMlQgfXQGEaoKLcndN9DLuBBFEwrzzlQ80=;
 b=bhpAXux9TYIu3cESGdgamzlGSuvCB34Z9XKrLV6fkI9N6JqWTmlgmNSVVi6xoIXNtNIg1em7NMcx9uFYtwwTKydcUaKKI5B0JNdZ66hD4rgmW8/bhEZP4VNNLexd3gjrAiCtW53SmKl7JzKxK0QbO46CNPWH79EeLeG/wBQ8LsQ=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by IA1PR21MB3688.namprd21.prod.outlook.com (2603:10b6:208:3e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.12; Wed, 3 Aug
 2022 16:26:10 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8%5]) with mapi id 15.20.5504.012; Wed, 3 Aug 2022
 16:26:10 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Topic: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Index: AQHYoIotS/wddpzfUkKuAt8ax//n6a2P8LwAgA14LMA=
Date:   Wed, 3 Aug 2022 16:26:10 +0000
Message-ID: <PH0PR21MB302502058A130F3529FE341DD79C9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <5ea65d3d-745e-0a16-c885-a224a20ee7ce@infradead.org>
In-Reply-To: <5ea65d3d-745e-0a16-c885-a224a20ee7ce@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2ebde30d-4fed-4055-bfbb-7dcc3b5d1a7f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-03T16:20:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3838251b-7e8e-4b6a-a2a2-08da756ce02d
x-ms-traffictypediagnostic: IA1PR21MB3688:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBjdk0Wzy7NDXf8mC8/w5Y1RYqeCvGGPuWeomlVJn0QKhpo2TGQuf/ei2FxThOtdqCCRIATUTmRUqy7bNOItw5hRujGf9t3Js6x8XGBKL5kN5rLE0MHhsiVNhjMGT2toZ7XMgltwYHbErKK+x5FAgiGPYxArft1bsnuatkE4efrk6ZFTaQDMQKeUndOGdvO7buk5wZyX7ujPEyJ29ZiF0LSnWENqmSOZfqeH47O2F1zWUvADyfOCnrqZkHq+HlKN+HqdJ93cYV44q+I1fHQv+7XSVP1ATR59vVZUJa3oFZJZg283n/LWbkr9ZYzWFSuseCKIw1Io23PnnxljI9EUE+1CMaVrOnwwC4dR2Mwx8zDw4FbfDOn+I/8V7Nxs00nsziJctGb80IPeb7BEuyNPPnltW157TDae1sQ8cOLLo67coyVk03dnsoWYAKj99LB6MfmebrggN/ecSalQy6omaFDKnCLXu7eat4NOcmu/K4PQQwiCliRIuR10bXcmuE3U9L3a9IBe61FS85roa7GmxH9sHWPPDVp7uXbT2H10WEergoxanydnU2l94u4K4fJ36wIGtNnoVLAPMvtFLj2EqWGrkFSHo2pH4uEGRv7GKFuKF8q/r1byl17ymU+qc+/UMKjTMFdmqwnMX23cZmnm/y6VvgWOQU1qzrhxy/Inm+P7qLj0zyYuW09tif13P0r0hZmwt8JsuCHgcrcGI42Bt5D9aP+nQqa3Q86FGVi4s6FdMMAD0V3tQ6UAV/jJmi9IXsWgEwJI/HKcJo4uZkbSRsU1BrhCJprHq3rLvPNpw8UEtuFDmoIbmpRZ+DoEB8B3JSwP+J4cBWUr/YjaOtCUxuwDb9FLp2PCRO+yb7nNuIgCH2xOXQwNztVn7mtdRtyB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199009)(83380400001)(55016003)(478600001)(186003)(8990500004)(8936002)(33656002)(10290500003)(26005)(7696005)(71200400001)(9686003)(6506007)(41300700001)(53546011)(38100700002)(122000001)(82950400001)(86362001)(921005)(82960400001)(66446008)(110136005)(5660300002)(2906002)(7416002)(52536014)(38070700005)(76116006)(316002)(66946007)(64756008)(8676002)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGM0TzBpc2JQa3UyVmF6a05FWE82aUNVY2dWZDJZWXJDRm15WUpidStERmJD?=
 =?utf-8?B?Z3Z5VWp2enNLYzhnaGJGNHhEUnJhYVgyZC9kSXExWk5ucmRkOTg3c3d4cFRV?=
 =?utf-8?B?a3BnSWYzK1JacTVCQmVMSldsOU52ZUxybEZsRjBWdlFnOHFuL2J5Rmd5RGd2?=
 =?utf-8?B?TEpuTE9qYTNjVHNaTSt6dXBXUEZybHBzZno1cUR1Mk53N1JTK1RaMi9zbERu?=
 =?utf-8?B?WFBFbm8xa0RSTEFIZ3A5ZjFOR3BBd1I1UE9kcmVUOVkzVHV3c0Rjc0RKR2NI?=
 =?utf-8?B?MFV3WTcwamloZUhjUE1aOHlFYjhWSU9NK2c1MHZaSFU3OGNIR3ZQcHBiNUNN?=
 =?utf-8?B?RHBKSG1wUVdza3JWMGJ5MTg3Q1NRU2ptbUJ1dExqdFoxL3pkeXRFczZyaFRB?=
 =?utf-8?B?eWxtdThzZ2dLZU1lclZrMlhCelFQQytMVE8rVUlMVEZkbTJrR2JhVFE1TkZw?=
 =?utf-8?B?SFRlQmFxdFpMNDBKYWtMcTBWTXZsbXE2MmRETklIVkQvUEpNNytGanpRakMr?=
 =?utf-8?B?YWY1eTBCSG9lTzBoMUJyQWw0a1RLZXRKS1NMT3VDQjArS3VlMjdOVGdZWkFj?=
 =?utf-8?B?aGU3KzJiTFJjbldjcFpoVjJ3RkhGK2ZzL1pUNDd5YlV5ZFNTTkViSXdOenox?=
 =?utf-8?B?MWFGRGV2Y085Qkc1RWVQeEhLVEZhSlM5NTNWQUtyOW9xOFFCZitXZ3RUU29E?=
 =?utf-8?B?aUJkV01LWFg0T214ZlR5M2dyV3Z0d1VGYmFFVnR5VjdDb2c1Z2RVM1BDdXA5?=
 =?utf-8?B?MXA2QmJmMm9VSWhRSy8xK21BVHByWHIvNVViSE9UNisvbGgvOVFJWGNVRXRz?=
 =?utf-8?B?c0I2ZURHK0VwWHVGbkR1bDBJMmt4cjNPRjVtbUpES0N4SzlVZmVyRGhxazRL?=
 =?utf-8?B?Uk16ekJmQmV3cG5tLzcvQnFCcmRvb2s2TFRQTGszNjVscnN0NXZqTVhHUDNO?=
 =?utf-8?B?WUFxSWs0RTk1NThEQkN3RUgycWZ5NXRvb3QycnRSMXlzcWhMSVY2MUUyV2Q2?=
 =?utf-8?B?aDYvaU5DQ0M0bXFZY1hOY1ZsclNYMXRPdmttSk5ySHMxU1kvRDdVS0ZLZEtW?=
 =?utf-8?B?ZTVYc3Z0M1pqRWJHejdqRnUxUFpsam43eXBxQ1ViemczNTFXOXV0K21IbUN3?=
 =?utf-8?B?RWVlTDlUS3c1ZUY4anhhWk9hR3dIeUk3VmdaR2dkUkM4OFVqVXMzTk9VVEdS?=
 =?utf-8?B?RXJBQmlwU1N5eGNjRkx0UjRRNFBnQXpkVmJleEdPb0xOSEoydDB3UkxxMjhz?=
 =?utf-8?B?aHZRR09WY2MrcW1UYjJFZGxUeGtFaWxJZTJ1OUhEOXpWd1psRldjZnFjMUZl?=
 =?utf-8?B?RHhWbDVqbzRJa09xaHNGcVBValdBa2I1dHltZjZONkFRY0JPWjhZQlFyMTFF?=
 =?utf-8?B?S0krVFZabm04WkVNY1hEcDRXZW1aWUV5SzlRVjFYWks5ekxBMStZQkNQZkF0?=
 =?utf-8?B?OXRmMWNMSUlBN2pDZllYTjhxWW1KSEwzQnZiK1k1VG5vVW5FOUUvaWpDaVFO?=
 =?utf-8?B?TGorSU1iTjViZzMyNEE0VitvbWpHdmZLVlZFZ3FIYzNRSWx2Kyt0VWpyaGVE?=
 =?utf-8?B?SzZVM0dQQTlrNUxoZUtReHRFSGZHcWw0a2xGcFVRVkVwcFNmNC9FVTVSR1Za?=
 =?utf-8?B?VjlnSDhnd2kwQUJLTExibnBQdTdLVkhkbmxrbVBOSUVJTE80QjV6czVISXox?=
 =?utf-8?B?MXFQLzJnTTJvdC80elYxMVZ3REs1SStIaVQ2eUUzQkFpSi9rdEM4dDh4SUxp?=
 =?utf-8?B?SlpuWE56aUFWbm0xTWtVZ0NUU1VESW1aRDh4OFZCWnErMVppS2lQdFJzTmFI?=
 =?utf-8?B?dUlpVEJxeHFBZU1zQit0S0w3ODZtemt5SU53bHY0WU8vdFdKZGcrVWN1czBS?=
 =?utf-8?B?c2xTVlNJNVRFeUFXT2Z0QU9FQnNtZWFKSDFzaWpxdVRMSHE2bTgzTzhxK1Ay?=
 =?utf-8?B?dEp3MWtBQVdqUERwUlo1eVZlZXVUK29iUXdIMWVYUTVoaUNxN2Q5ZEVuRm84?=
 =?utf-8?B?SG5wWVIzblByZUQzZW40Y1ZvVjhQcWt1c0FQR2lBVmRaZFpWZkI3UlB6eU5t?=
 =?utf-8?B?OXU2LzZZTUo3NVZiaUVKRWpTL3htVFR5QWowOVhUWEZFa0UvQ2lwcjJCV2Rz?=
 =?utf-8?B?cGE4VjJ2c2hwWjZzNEcwZEduaHg2Vzl0NUtGU2Rva2pMNEkrd2M3VS9VWGtn?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3688
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IFNlbnQ6IE1vbmRheSwg
SnVseSAyNSwgMjAyMiA3OjM5IFBNDQo+IA0KPiBPbiA3LzI1LzIyIDE3OjUzLCBNaWNoYWVsIEtl
bGxleSB3cm90ZToNCj4gPiBSZWNlbnQgY2hhbmdlcyB0byBzb2x2ZSBpbmNvbnNpc3RlbmNpZXMg
aW4gaGFuZGxpbmcgSVJRIG1hc2tzICNpZmRlZg0KPiA+IG91dCB0aGUgYWZmaW5pdHkgZmllbGQg
aW4gaXJxX2NvbW1vbl9kYXRhIGZvciBub24tU01QIGNvbmZpZ3VyYXRpb25zLg0KPiA+IFRoZSBj
dXJyZW50IGNvZGUgaW4gaHlwZXJ2X2lycV9yZW1hcHBpbmdfYWxsb2MoKSBnZXRzIGEgY29tcGls
ZXIgZXJyb3INCj4gPiBpbiB0aGF0IGNhc2UuDQo+ID4NCj4gPiBGaXggdGhpcyBieSB1c2luZyB0
aGUgbmV3IGlycV9kYXRhX3VwZGF0ZV9hZmZpbml0eSgpIGhlbHBlciwgd2hpY2gNCj4gPiBoYW5k
bGVzIHRoZSBub24tU01QIGNhc2UgY29ycmVjdGx5Lg0KPiA+DQo+IA0KPiBSZXBvcnRlZC1ieTog
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IFRlc3RlZC1ieTogUmFu
ZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IEFja2VkLWJ5OiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvaW9tbXUvaHlwZXJ2LWlvbW11LmMgfCA0ICstLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaHlwZXJ2LWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2h5cGVydi1p
b21tdS5jDQo+ID4gaW5kZXggNTFiZDY2YS4uZTE5MGJiOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2lvbW11L2h5cGVydi1pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9oeXBlcnYt
aW9tbXUuYw0KPiA+IEBAIC02OCw3ICs2OCw2IEBAIHN0YXRpYyBpbnQgaHlwZXJ2X2lycV9yZW1h
cHBpbmdfYWxsb2Moc3RydWN0IGlycV9kb21haW4NCj4gKmRvbWFpbiwNCj4gPiAgew0KPiA+ICAJ
c3RydWN0IGlycV9hbGxvY19pbmZvICppbmZvID0gYXJnOw0KPiA+ICAJc3RydWN0IGlycV9kYXRh
ICppcnFfZGF0YTsNCj4gPiAtCXN0cnVjdCBpcnFfZGVzYyAqZGVzYzsNCj4gPiAgCWludCByZXQg
PSAwOw0KPiA+DQo+ID4gIAlpZiAoIWluZm8gfHwgaW5mby0+dHlwZSAhPSBYODZfSVJRX0FMTE9D
X1RZUEVfSU9BUElDIHx8IG5yX2lycXMgPiAxKQ0KPiA+IEBAIC05MCw4ICs4OSw3IEBAIHN0YXRp
YyBpbnQgaHlwZXJ2X2lycV9yZW1hcHBpbmdfYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFp
biwNCj4gPiAgCSAqIEh5cHZlci1WIElPIEFQSUMgaXJxIGFmZmluaXR5IHNob3VsZCBiZSBpbiB0
aGUgc2NvcGUgb2YNCj4gPiAgCSAqIGlvYXBpY19tYXhfY3B1bWFzayBiZWNhdXNlIG5vIGlycSBy
ZW1hcHBpbmcgc3VwcG9ydC4NCj4gPiAgCSAqLw0KPiA+IC0JZGVzYyA9IGlycV9kYXRhX3RvX2Rl
c2MoaXJxX2RhdGEpOw0KPiA+IC0JY3B1bWFza19jb3B5KGRlc2MtPmlycV9jb21tb25fZGF0YS5h
ZmZpbml0eSwgJmlvYXBpY19tYXhfY3B1bWFzayk7DQo+ID4gKwlpcnFfZGF0YV91cGRhdGVfYWZm
aW5pdHkoaXJxX2RhdGEsICZpb2FwaWNfbWF4X2NwdW1hc2spOw0KPiA+DQo+ID4gIAlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiANCj4gLS0NCg0KTWFyYyAtLQ0KDQpDb3VsZCB5b3UgcGljayB1cCB0aGlz
IHBhdGNoIGZvciB0aGUgNi4wIG1lcmdlIHdpbmRvdz8gIEl0J3MgYSBmaXggdG8gYQ0Kc2lkZSBl
ZmZlY3Qgb2YgU2FtdWVsIEhvbGxhbmQncyBzZXJpZXMgdG8gdW5pZnkgU01QIGFuZCBVUCBoYW5k
bGluZyBvZg0KYWZmaW5pdHkgbWFza3MgdGhhdCB3ZW50IHRocm91Z2ggeW91ciBpcnEvaXJxY2hp
cC1uZXh0IHRyZWUuDQoNCk1pY2hhZWwNCg0KDQoNCg0K
