Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51576172CE
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 00:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiKBXjN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 19:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKBXjA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 19:39:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021025.outbound.protection.outlook.com [52.101.52.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9419C08;
        Wed,  2 Nov 2022 16:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5YtWvCkOYnwO0Qh36aruE/oZTCFT00eOogHlygAQHb8I7cg5e541E7qI64whfqkbxagTTneRwCGLzngcF53D+3al+02wOrKOAYoTrVSFgYEXiZUjDWJ3qsBb2gPWZaJuNmQaKI3FS2JiMs8h9OzsQcapwApgJ4FcyALURdqSauC56Awu1NkIQs0o8Nb+BfvVZZQcQs/7tWz7NJsHtmRkTQiKg2LU7RRVSc7fcsH0Vw+bqri+fz00wsWtpL4w0QFseT5Vh7xFcfnHBrt+1nNaeEF4a5mRcQCZfPQZvttSdoN9vz7dCyn8GPMgrrD4BtUvWWI1O761B4BeY5dvZ0xBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxGvyUScDsy0/kgj44Usi3eXQorrqk/19qeG2u6ZakU=;
 b=n10uozMcEqCRL5BOJk/5jYO+nwxUHNjpQRUcQ5VBuN+AbrEH2YLO+CY4AmeXALmE1A6hPJPcAvD70SlsbJQGEXFDISZ4uo1iF1J8zo+IMQ98ugMRcjkV/mkVCY0uKLsW4td/yhXym402mxjkxO3ZGnuCyWrid9Ht3xx4lijyH+v4uOi88hnAun4xB5d0hv0hTepm99+O5CTv3SAaYoZAJtgrjqe9RuA2QcBEz9sNhO0rVmuXZrKWUrV7hIT38HadrgEq20yfbBrgGN91YoAo+xv8Dw9JjzQUUiXhtmoeIhHoW3hB1PX5iyXWRC0GNKOUgY7HbeHZLhcMRwnLOPlZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxGvyUScDsy0/kgj44Usi3eXQorrqk/19qeG2u6ZakU=;
 b=iM4daDiIks5+UJDJg6+NGx2m3dWNZW66gdjw9XmzzRDyZZHGi4kIW2FHNjrVMxOURs8MZpLaju4nrZhLqswqEfHUaGhxvA3836I8+d41RvPxcAMN0AWJZc+IAWiW4zm3JeSL/0UxE4HKwbnIDarISsB3uwXVN2bbc5FOnpORCjE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3360.namprd21.prod.outlook.com (2603:10b6:208:380::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 23:30:15 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 23:30:15 +0000
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
Subject: RE: [PATCH v2 2/4] drivers/clocksource/hyper-v: Introduce TSC PFN
 getter
Thread-Topic: [PATCH v2 2/4] drivers/clocksource/hyper-v: Introduce TSC PFN
 getter
Thread-Index: AQHY7weQXCovCPj+PUGXTaK1x6iqXq4sRXJA
Date:   Wed, 2 Nov 2022 23:30:15 +0000
Message-ID: <BYAPR21MB1688D503DF583914F4EC0356D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166742684944.205987.13495997217797904022.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166742684944.205987.13495997217797904022.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2ba9d2a2-9271-40f5-bd81-eae40331ec35;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T23:20:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3360:EE_
x-ms-office365-filtering-correlation-id: 3ff8178d-f604-408c-324c-08dabd2a3241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaKpkAOnRyuIdGNyvW0smprtaRYKb19ntbAuzqLDF5SNS9wkGfDsypTpIdw5mQMr3OWBUi15s3hx/jQG9IF134m+8ELyEcCSoeNc5DGYNU8EjHb+d+sxzp14Ei4PTHFfDTxJCYgqFt5x+m8yoOdLRQr8RXWfCCaBd1wDroF+TjlhADxyodWwl4nX9AhcSYhAShG6wcnMl3n1nTOqExYLsUW2aKhTLIPLO3UYT/7CxoUmfAuQOBYhUWFOJQ/pOpm7h6OJnE5V6SOoD7NHjuihadTpWLnhNorAGuegNM368I70Fmn4foOqXnQ9HSuisY/ZSC7VTK3bfXJuoGWBsBCzGxr/4GmAW8b4y6DXZeoEBFY6uEXHmnQx1EIU0cCltKPBdrhysy6cKPH9TTKU26o0BdrSgZ03JaZmUFtVNhft1Gag4LbgkvD3T5+HPNXYpoANUVTTLp0E++o+KN3W6NkT1MDd5e+zj9dfeuZ99iPJQVcWCKyDYgg2+p3gmHgxg+XJ2KDM4IdLSIFjZ6FQaq66YvfRS/e/wI335Ipcn9239Cz7eo0JVhJIwyymqbYohAjbs5Ps2pToSus5Sg8Hhcwu12N724B5PXEaYV4T8YDtil5662Rgm4k5SHav550DzG9bz2f1sM+3DRmMHiJPy2fnk20Guv0Ca7yaWBRgPKwJy58/zsShIODHolJCMxKi1kI8Br6vrUk088Gn/0hW+cvhaZtcBxSEBLa87f6dBuxG+7R1cMkHxAygd2OWpsadWCMAERtLfGk6vuvNTRh7+Sy3uSSFWv1iiBhOV14jM/wKZAElll7Ls3lqi2yyUyOO34NK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(6862004)(52536014)(38070700005)(8936002)(33656002)(5660300002)(54906003)(82960400001)(86362001)(41300700001)(4326008)(316002)(66476007)(8676002)(66556008)(76116006)(64756008)(26005)(66946007)(66446008)(6506007)(7696005)(9686003)(83380400001)(10290500003)(186003)(55016003)(71200400001)(82950400001)(8990500004)(122000001)(478600001)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0hkVk5ZQXphU2xZTWJRRWFwRGIwWE1sMmJDZWlJQjcwWTc0Yy84T1o3VS9r?=
 =?utf-8?B?UkVJRGlzOHVtQXkvdjNXWURIcjRTaGlrOWJacTZZZFJ2RTdGdUJncGhQemgr?=
 =?utf-8?B?eVptSUJuSUt4dEI3V0NuR3BtSTV6ZFdtbjRkWVpvdnhtdmgrR0Eyazg0OUxK?=
 =?utf-8?B?L2VjN3NQSnJ5am5DeVpMR1VrbVZZZjNnSGRaSm9Zekw2QWFydTl5Z1k2cjJm?=
 =?utf-8?B?L1hSV0pDQk5icnhPSG00M1JjcFkwODVBUEg4K2ZmYTlKMCtsbVNXM0Z5aG9y?=
 =?utf-8?B?QVZSeThDQ2tTQ1BKYnI4dld2WnNwazVFMWUwdFptMEU2UGFnTEFpdjFteTJl?=
 =?utf-8?B?TUR2YkVsK3hvcUVvZmF0Qklnc1Y0V2Q3M0REaTJtNjVUZm1MUEc5MVdQMUor?=
 =?utf-8?B?TktUVVJqK1djYnhvdlRTSlB4Z2hEUENuQndYZ0Z5cnFDQ1dybnVRSGpwQjJY?=
 =?utf-8?B?NzJlR3M2WlIyRnVrUU10NVNJZGFIL2pNblUrZHRIYy96aSsxTW1GNUd5WVZZ?=
 =?utf-8?B?RWtLNDB5dCtWV2sxa3krWHlXZU1adVV1K1NFaEorakszR2JLd3VNTzJUcGFF?=
 =?utf-8?B?SkNzMENCaHQ4MVRqaUpCN2VNVkwzT1pYTlRxK2srNU85OFhkZGlOR1lmWE9s?=
 =?utf-8?B?QlRvT3U4dkVVTDRadlRGRUxqS2hKRklJUWR3NHIxWERTc0EvNmxPa3hOZGV0?=
 =?utf-8?B?WVpzRE1UOTVFT3RNWFBDbUxyUmRjaHB2cDcxMlJYTm9qYVN3NEZ5UWFiR0lm?=
 =?utf-8?B?dHdYR1YzMUlkY3Jydk1PT20waHJlbm9kZnZad0hCOENGdDJadjBkVW1ZT1Ra?=
 =?utf-8?B?SFk1MWxQVWhnc01IangyQ2NKc3FyUG9NZS9tZ0s3WUozYlZHNnVDRmVxSUE3?=
 =?utf-8?B?YzBNcUlYVENiWlVXL09ERVg4b3JoTDRKQ25pOEovYjlwT3dzaUNZb3VhNm5n?=
 =?utf-8?B?V1pUMGd1UytLTnNwVzZlOERiaDNEaEdjN0VFc0JCZG5WNEZ3QnlTVHdxYk41?=
 =?utf-8?B?eVJtSmNzdGwzQzE3dXRWL1Y3THlTbGcvN2hQK0QzS3ZpYnRDR0p6QklndlQx?=
 =?utf-8?B?OFJqSFlJd25zNCtKUnNHM1hnZ0dnUXBFaUZtdXI2elZxbkNPWWMreGhpbDBh?=
 =?utf-8?B?WDByWGdJZWFNbnI0dTE1YkRSQ0h0dXd5UXBJMVNUVjJRUTJKbElsZXViZSt5?=
 =?utf-8?B?RU1nQ3dDYSt1Slo2ZE1lOEl3Vk5mOGpFK3llV2dPaVZYL1FGQ1o2cGI0Z21n?=
 =?utf-8?B?RWplSnhrZGtGMW1lazlNVjVJSWErQklpQURGejNLMG1TdWxmcjJHbno4K2Nw?=
 =?utf-8?B?Mk5CbGVYazZOY1pYejBkSzNxK09zZjVLVnhTdTJzOHcxaHZoRGZTbWFCaTRw?=
 =?utf-8?B?UFNVZDJKWGFKNUgzcEZyajBjTUNvYm95VjdUZDM3NUJKbTBmM1JOQTdPdDdM?=
 =?utf-8?B?aHVBOWc0cm9xeHJGNm8rUE5BWHZZVHhnNVFvL1N2TWYwcEtBaC91WDlXUFo4?=
 =?utf-8?B?cFlwYzJNVUlJeFBOYmoxejZ3ajROZENmajFLV0U2WExvMWEydU96MHlTMDBR?=
 =?utf-8?B?M2pGcElZK2Y5RmhoUjlNUjVZZjYrcUFiVjJRSEtGVmpGMnJZaC9HVW53VzNq?=
 =?utf-8?B?U2liUzBTRDlCbE8zZFl3UkdKRjhUSzJ5STdYd0NZY2h4bG9GUVN5QlBsUjFs?=
 =?utf-8?B?V3F4cWhIS3RmTmlMS0pha3JwQ1A1T3RTK3JuTVBMTGtPUHFjTUFOSU5OUTZw?=
 =?utf-8?B?NHlkdnF3VHA1TENsMVJISG9IdmZBNVFyKzFJelJTYjFJMmdPMng0RjhjN21N?=
 =?utf-8?B?RTZqdmt4d21rUCtmancwWTdKSk9iSERQOU55b3VrUUZPVjh0V3J3ZmM0UUcv?=
 =?utf-8?B?Q2tmTGpQc1ppMDBpSGUwNHVzSTcrVFp4OEdFUlIxakxuOVo1NktrQ1VYUFVX?=
 =?utf-8?B?QVZJYjNQcjdMWDh6Y0dJa1JMaDEzVUNyL2VRRklGZWVYdXNvMjhsdldTR1Ir?=
 =?utf-8?B?QjdOZlZRZUxOdTFKYTdKNEdxd2hsNVBJVlVJSmZqK1BERWFkd2NBS2toMlRk?=
 =?utf-8?B?Z0dNMnpacHcrOHNCdkVlVGNLWTZBRjhNRlExQytGYW45YUh0TVZFdTVTZzlJ?=
 =?utf-8?B?SkhzbVFnOTl6WUd4bkFlZVNBQTRnUnZFU0tQTGFlOWNIUHVZRG8vMWxDUkV6?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff8178d-f604-408c-324c-08dabd2a3241
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 23:30:15.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNk1QOrAWLcgMfkpvou0tnBWsGVRtrUla4XIwhhUGSD62fh/2eKdfObcVmSF0IcJ6RmHwnLVTwdH3OoY2jFp0ma5HKUBfT2nuXqDOkeuc7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3360
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
LmNvbT4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyLCAyMDIyIDM6MDcgUE0NCj4gDQo+IEFu
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
eXBlcnZfdGltZXIuYw0KPiBpbmRleCBjNGRiZjQwYTNkM2UuLmQ0NDdiYzk5YTM5OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KPiArKysgYi9kcml2
ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+IEBAIC0zNjcsNiArMzY3LDEyIEBAIHN0
YXRpYyB1bmlvbiB7DQo+ICB9IHRzY19wZyBfX2FsaWduZWQoUEFHRV9TSVpFKTsNCj4gDQo+ICBz
dGF0aWMgc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAqdHNjX3BhZ2UgPSAmdHNjX3BnLnBhZ2U7
DQo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyB0c2NfcGZuOw0KPiArDQo+ICtzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBodl9nZXRfdHNjX3Bmbih2b2lkKQ0KPiArew0KPiArCXJldHVybiB0c2NfcGZuOw0K
PiArfQ0KPiANCj4gIHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKmh2X2dldF90c2NfcGFnZSh2
b2lkKQ0KPiAgew0KPiBAQCAtNDA4LDEzICs0MTQsMTIgQEAgc3RhdGljIHZvaWQgc3VzcGVuZF9o
dl9jbG9ja190c2Moc3RydWN0IGNsb2Nrc291cmNlICphcmcpDQo+IA0KPiAgc3RhdGljIHZvaWQg
cmVzdW1lX2h2X2Nsb2NrX3RzYyhzdHJ1Y3QgY2xvY2tzb3VyY2UgKmFyZykNCj4gIHsNCj4gLQlw
aHlzX2FkZHJfdCBwaHlzX2FkZHIgPSB2aXJ0X3RvX3BoeXModHNjX3BhZ2UpOw0KPiAgCXVuaW9u
IGh2X3JlZmVyZW5jZV90c2NfbXNyIHRzY19tc3I7DQo+IA0KPiAgCS8qIFJlLWVuYWJsZSB0aGUg
VFNDIHBhZ2UgKi8NCj4gIAl0c2NfbXNyLmFzX3VpbnQ2NCA9IGh2X2dldF9yZWdpc3RlcihIVl9S
RUdJU1RFUl9SRUZFUkVOQ0VfVFNDKTsNCj4gIAl0c2NfbXNyLmVuYWJsZSA9IDE7DQo+IC0JdHNj
X21zci5wZm4gPSBfX3BoeXNfdG9fcGZuKHBoeXNfYWRkcik7DQo+ICsJdHNjX21zci5wZm4gPSB0
c2NfcGZuOw0KPiAgCWh2X3NldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDLCB0
c2NfbXNyLmFzX3VpbnQ2NCk7DQo+ICB9DQo+IA0KPiBAQCAtNDk4LDcgKzUwMyw2IEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBodl9zZXR1cF9zY2hlZF9jbG9jayh2b2lkDQo+ICpzY2hl
ZF9jbG9jaykge30NCj4gIHN0YXRpYyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJj
ZSh2b2lkKQ0KPiAgew0KPiAgCXVuaW9uIGh2X3JlZmVyZW5jZV90c2NfbXNyIHRzY19tc3I7DQo+
IC0JcGh5c19hZGRyX3QJcGh5c19hZGRyOw0KPiANCj4gIAlpZiAoIShtc19oeXBlcnYuZmVhdHVy
ZXMgJiBIVl9NU1JfUkVGRVJFTkNFX1RTQ19BVkFJTEFCTEUpKQ0KPiAgCQlyZXR1cm4gZmFsc2U7
DQo+IEBAIC01MjMsNyArNTI3LDcgQEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Ns
b2Nrc291cmNlKHZvaWQpDQo+ICAJfQ0KPiANCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVy
ID0gcmVhZF9odl9jbG9ja190c2M7DQo+IC0JcGh5c19hZGRyID0gdmlydF90b19waHlzKGh2X2dl
dF90c2NfcGFnZSgpKTsNCj4gKwl0c2NfcGZuID0gX19waHlzX3RvX3Bmbih2aXJ0X3RvX3BoeXMo
dHNjX3BhZ2UpKTsNCg0KSSBwcm9iYWJseSB3YXNuJ3Qgc3BlY2lmaWMgZW5vdWdoIHdoZW4gSSBz
YWlkICJ5b3VyIGNob2ljZSIgaW4gbXkgcHJldmlvdXMNCmNvbW1lbnRzLiAgIFRoaXMgc2V0cyB0
c2NfcGZuIHRvIGEgZ3Vlc3QgUEZOLiAgSW4gYSBndWVzdCB3aXRoIHBhZ2Ugc2l6ZQ0Kb3RoZXIg
dGhhbiA0MDk2LCBpdCB3aWxsIGJlIHdyb25nIHdoZW4gc3RvcmVkIGludG8gdHNjX21zci5wZm4g
YSBmZXcNCmxpbmVzIGJlbG93LiAgaHlwZXJ2X3RpbWVyLmMgaXMgY3VycmVudGx5IGFyY2hpdGVj
dHVyZSBhbmQgcGFnZSBzaXplDQppbmRlcGVuZGVudCwgYW5kIGl0IG5lZWRzIHRvIHN0YXkgdGhh
dCB3YXkuDQoNCj4gIAkvKg0KPiAgCSAqIFRoZSBIeXBlci1WIFRMRlMgc3BlY2lmaWVzIHRvIHBy
ZXNlcnZlIHRoZSB2YWx1ZSBvZiByZXNlcnZlZA0KPiBAQCAtNTM0LDcgKzUzOCw3IEBAIHN0YXRp
YyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCSAqLw0KPiAg
CXRzY19tc3IuYXNfdWludDY0ID0gaHZfZ2V0X3JlZ2lzdGVyKEhWX1JFR0lTVEVSX1JFRkVSRU5D
RV9UU0MpOw0KPiAgCXRzY19tc3IuZW5hYmxlID0gMTsNCj4gLQl0c2NfbXNyLnBmbiA9IF9fcGh5
c190b19wZm4ocGh5c19hZGRyKTsNCj4gKwl0c2NfbXNyLnBmbiA9IHRzY19wZm47DQo+ICAJaHZf
c2V0X3JlZ2lzdGVyKEhWX1JFR0lTVEVSX1JFRkVSRU5DRV9UU0MsIHRzY19tc3IuYXNfdWludDY0
KTsNCj4gDQo+ICAJY2xvY2tzb3VyY2VfcmVnaXN0ZXJfaHooJmh5cGVydl9jc190c2MsIE5TRUNf
UEVSX1NFQy8xMDApOw0KPiANCg0K
