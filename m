Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA6618A11
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 21:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKCU7p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 16:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiKCU7o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 16:59:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021015.outbound.protection.outlook.com [52.101.52.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EDD65C7;
        Thu,  3 Nov 2022 13:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPQQfkoj5yfG0RrwmbcMru2ZdlUal9RStBb86BzK4uefEK/530R2jxJQ/prmqCRhCNmy0+CrCRhhrP6B8D1ev4OE29o7G2tLZeutimN0oDX3ZJuX8pGLY+3ODiE4iLHeIZBBDZNjuswWhgPll8khsFSwdi8GG/gmAOJ2RPr6dhF5tFJHeu9d4bd5vsbeNztgVl6a4kvuUzFFjF6vi52C/X9vNjI1guManP5DRn4Ki6+KPVE5dJIaITGk/5qvc/Vx+ZdPoZzdDC9iLn0LRqpyfMiXmM+PyuEkrdsr6t1qrm4Q58I5N647wT6d96SQw+fsoElC6nTXodF8EJz0wjqnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMJ9uU8VmxxiysMEtGpVO5u0608pUw1h8cLcEbE9RaY=;
 b=nLVojLFZ10h3hdtkGwU0VPnhMPJGgAlJ7gzc8kF6D0HZwQWFFzQF7GAvSaKa1W6m6gVezvcYjAawy8UbQ/zE6PgVHTNUc8i+2WNj8DMs7mzVMbAT94BMvw7ws7ntgjQ1IhiIMbIpogAG3W2SMnVZ8S4e6YUUtq+j2cSV/nWjxkOk9UTeocvssas4Kq8+yL83ElgOLHePkJ35uQzH9ixxvqpnrRdpAKYhMcO3meb8YuXzCUC11HrCPhxqYH37VGiIKJK1IXJ+q3d1XbtofdTHqNNlttLL7zG1qdxog/YM9oxV7NnFyfa5SJ5WSKupy0IexnL26hFAWtKcASspUDsNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMJ9uU8VmxxiysMEtGpVO5u0608pUw1h8cLcEbE9RaY=;
 b=R2ObDSN+c3QXj9nRflJeq42C3QjzBkpak/YQLf3cVSUUeZW2wcrJl4KsOai6Ec/7iTxMDaQH/aIjivfZP9xWMCTSgYUDQTUTkUBywTNSI/ZqYqwY10QtCOmI9Gnh8i+aqqt4AHtGzCHyWO4dM7/YHYUUFsTD1h/6HIzx1vEcOH0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1879.namprd21.prod.outlook.com (2603:10b6:510:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Thu, 3 Nov
 2022 20:59:36 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 20:59:36 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] drivers/clocksource/hyper-v: Use TSC PFN getter to
 map vvar page
Thread-Topic: [PATCH v3 3/4] drivers/clocksource/hyper-v: Use TSC PFN getter
 to map vvar page
Thread-Index: AQHY76318bjI5hQQwUWSS+/G2x25qq4trtGg
Date:   Thu, 3 Nov 2022 20:59:36 +0000
Message-ID: <BYAPR21MB1688BFD31B3F71C7BA8F46CAD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749833939.218190.14095015146003109462.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166749833939.218190.14095015146003109462.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b34d33d-0e78-4584-bd0c-66e099291c2e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T20:58:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1879:EE_
x-ms-office365-filtering-correlation-id: 676e9c60-0dc6-4e17-bc60-08dabdde5111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBunF/TdMjl7Rz2UXBkX2r60wy3ZjyOfy0PYARDhfrCMNLFmgV4GOj2910hbMgwdGdQq4sBIvf9z0TjYoKHb2cpg2d25seimlf2VUIcsYaFpMhdohXFfMFaQct9on/khpmSKBlsqmtXVAeR5NmweIZAINqoPwdxATjvNJjnRP8hR9vmyDh3miYjXpQQYyagPUWSmLl52qxAT10GUduHZEbuvDARTUG19cg6A3SI7mhuZ4MvQJmtVy0kZc/PtRRv82IXJd8ETfHU3qMfZI6YR4T3RUiI/aW8feGTMmALPGI+Fp2VYBwmih61WDQKLGFDe4i3/Q2EvByH9lQw9KFJzuY7XMXAsq1MCVkAAISfaxeKRq2yHKSDVfeGXcCZoVo4PqOHQ0BNPaSqzVFNybhlmlovYrhby6/3lsKXr+iAWOHQkOSebBEjw4Hk8UoecrzaatMXEuqE57XqKUlzb5YiiwIPzLH+9exYVj8Hu3rg+f5tPGxnul+UjXodfebud8DDz+5ZS7QsQ/OEp4mrQv/ZIVgb7OyY02r/06og1ilKkzls1D11iIytAiOmGP3oR8MdQ+63UVOXW/FN8JwsD6PK98LcTyPaV/N9zeOJpEo3OfDnwQi07LyRKvpgm0WVqOgMMsCuLJ6TARmmdlJzxG3jCmUWSsywiqqy/HNJnrYLeTxUJsB4aTlU7bRxrsy17rSSLRfe2gDcUBiri1CJLvkvrIkzWifCc6FwHo6xlYjX3w5+NLnl4nFOG+7x1IiHytErPxUIxIXKFH+W/FGFH81uyS3Rr0hIZ/BjnrUX1vEFkGOIzgMyDrIeCxl+6SYd3eOln
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(186003)(9686003)(83380400001)(6506007)(26005)(7696005)(2906002)(122000001)(55016003)(8990500004)(7416002)(71200400001)(54906003)(10290500003)(316002)(64756008)(478600001)(76116006)(5660300002)(41300700001)(8936002)(66946007)(4326008)(6862004)(8676002)(52536014)(66556008)(66446008)(33656002)(38100700002)(82960400001)(82950400001)(86362001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzFJUHNOVzJ0anRJdGhldTI2ckMxRjR3UWI5V0VhWGJRdFR0ODlTb3NnKzBI?=
 =?utf-8?B?bkc3VnFON3JaUW0zMFo5WFVTczFHS2NyZ3g4WmtiVGNaVEYxQ2JqZkRLenQx?=
 =?utf-8?B?UVlnVnhzS3BVOUNaQlk4NlFsMW9kcDJGYW9tSEE1QXEyRGJyR3o5K1JWdnR2?=
 =?utf-8?B?ZVVHQXZzbnhpZy9vUGNTdk5SSzNzT2o0RE1BQ3VDOXRNYWxNSlZHdm50UE5n?=
 =?utf-8?B?QlA5VnBkZ3RhOExSWDVpdDB2dkV6Tlp3TTIrcnlEMDFBWDNZRzZGQjB2TEd0?=
 =?utf-8?B?a0NDYk9WNFlUQ2FFUGVHVVh6eTVNZmh2aktTV1JIenBoMmxpU2tLTEtmaGxY?=
 =?utf-8?B?S2x5bmNiYk9lanJ4RUZmVVFVL3RQWHh5QWYybkp4YkZjV2lpeVVTTEZhckFr?=
 =?utf-8?B?bFRuL3ArVCtrTk43ckVMbUhtV2VEaDJHTXk0NTN2aHdXWVhkNHNtaU40NG9Z?=
 =?utf-8?B?a1pUVEVORTF2MkxCQ0lHRWxTbTlLYnhnbnplYkZPVmh4YWVna1JaQ09iZ1JI?=
 =?utf-8?B?cDJsdi9iNnNOdDAySTNuRjF3SG9BUnF5WnFOQ2l4RTZzZE5ZR0h4VDRCV0FS?=
 =?utf-8?B?N2FnbWI4RmFhQ1dJalBranMrNGlzWFJOOFZYd2RubVpKNXZHMjhqRzhKYzJq?=
 =?utf-8?B?dUhDK2xjV2VjMlV6Y1NDc0FCMENLaFRjVEJDYUxxMFo3SHB4ZEoreVVHY1VG?=
 =?utf-8?B?aGw1TUxoVW81aWk1M0dQWUtjRmI4dUQyMXo1OElNanBYM3JGMkU5eXNGL2ha?=
 =?utf-8?B?Z01TcGhlaTU4bE41aVJLdXA0Wk5kb25mV1podUlXbGNrS29URGJ1eGU2UlJu?=
 =?utf-8?B?VVA1cGNjcitva1NUTWF1UDFXbWlnSUdQU1lhanJoNHRZUDVXc08rMEZIbE5a?=
 =?utf-8?B?SFhPeGxpbmNmMGF1c3VtZi9QUVFSeHlXTHpic2g4T2tKYjJqdWlnTnFoQTM3?=
 =?utf-8?B?Z3pEMnNYM2ZsWE1UZXJaQUYzdHdpVS8rUUZ0eVhRWGJxbGd5amFyajdSWG55?=
 =?utf-8?B?dDAzS3pZSmJ1dCt4ZFNaWkNpZGp3RHdtUXoyTDFOQjI5QzRkTkk0ZGdaQmNB?=
 =?utf-8?B?SmlQWEZBd1BFbi8yU1paZ2hJNVpFOU5aUS9DTSsxa21uS3lVS3lyT3BMYURw?=
 =?utf-8?B?NnAwU2RtVXc1TFRQYmFOQWtoKzVkUUlvVVBxRnhzMTdTVDloZFdLYUN3OVg4?=
 =?utf-8?B?YmIrNkdwVlZNak83bGlTTktDQnBPMGxUQkx2bCs4MWFkb1ZwbUVHMmZZZEJC?=
 =?utf-8?B?TzZqeExINFpIeUR3eXBjVVZ1cllzclkvODZnNzU3akNqbnFMdnIybXhUZXcv?=
 =?utf-8?B?eFVwZE1idkVLSFhNNG1MS1gxc1IxaTIwSk04VWR6ZGU1WktvZFVSQkRnR21G?=
 =?utf-8?B?L0labTM1TkhxN0RlMnRZeW03MFBNZ0xtYk5jTlZZTW9yRnRTMkpiTE5DZCt5?=
 =?utf-8?B?bUMyMDdUdnA3bCtIbVRZOGRucnlCQTV3U0lTUlFsd2hZTkZlYmkzY01Wcmsz?=
 =?utf-8?B?K3BJZ2JHbUdvQVhBeDd4bUFKYXZwb3FCekgzSUdxOEVGVUQ4OThpdzd3RThk?=
 =?utf-8?B?M2lGUjZqNXhZR0c0NWFrM3Z5OFd6ZUJ4YnJ5WnZXN04wMm8xRERKdzJ1TVBx?=
 =?utf-8?B?L3BtK3V5ZExoUGZqbWpraEJ0bk5LWW1BMWVvVWxyZThoU01wZmw4dmtXTDFr?=
 =?utf-8?B?SVFraXNwZC93QmU5RTdjTk5tWHI1djJrNm13UVJPbWp1T2lUZzBna05XQ2Ra?=
 =?utf-8?B?UmZ2bis3MnlnSE41T2Z0ZGt1YTlyK1JTQTVtS21Rb3lZU1gvSzJ4YXJzbGRY?=
 =?utf-8?B?R0dhUXJUMXFLbVV3QnR0ejBidW54aE9RbElPOFhiMVlEZWhzSTdEN2dwRW1k?=
 =?utf-8?B?VFd3cG9ud0pRWUV0ZFRobStwbDczOWpnMERvZXdVY3E5bGxSTzMxK1R1Wjlu?=
 =?utf-8?B?ckVIZWtYcmdON0k4SzRGUHp1N2tYeGV5TklqeXYwV040eE0rRzh2d2pPb21T?=
 =?utf-8?B?Qm4vN0ZIc0E2L3JFekprQTdkREVNb2h3T3p0SjQyNy9FWFRSMFh2SFJIVzFL?=
 =?utf-8?B?bHRsbjBlUW9sTXR3SGRTWld4ZGxpYUw5MFpzYVptSmRmOUpQQ056MExDTjI5?=
 =?utf-8?B?dnkzd29mZmtrWWlpL1FLQjJjRFRCbTdyU0NiSVZpekhYajF3Y25IMDRNelpZ?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676e9c60-0dc6-4e17-bc60-08dabdde5111
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 20:59:36.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xICMW0l6aXR2JimBlmyrF9HXId8Ch25unbzMrS6xh0qU7YHoDBoI1mLWIj+cdDBkqM48QAtRf5NZA3e059qg6J22ERfSg3fLmbbYR4p96bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1879
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
LmNvbT4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMsIDIwMjIgMTA6NTkgQU0NCj4gDQo+IElu
c3RlYWQgb2YgY29udmVydGluZyB0aGUgdmlydHVhbCBhZGRyZXNzIHRvIHBoeXNpY2FsIGRpcmVj
dGx5Lg0KPiANCj4gVGhpcyBpcyBhIHByZWN1cnNvciBwYXRjaCBmb3IgdGhlIHVwY29taW5nIHN1
cHBvcnQgZm9yIFRTQyBwYWdlIG1hcHBpbmcgaW50bw0KPiBNaWNyb3NvZnQgSHlwZXJ2aXNvciBy
b290IHBhcnRpdGlvbiwgd2hlcmUgVFNDIFBGTiB3aWxsIGJlIGRlZmluZWQgYnkgdGhlDQo+IGh5
cGVydmlzb3IgYW5kIHRodXMgY2FuJ3QgYmUgb2J0YWluZWQgYnkgbGluZWFyIHRyYW5zbGF0aW9u
IG9mIHRoZSBwaHlzaWNhbA0KPiBhZGRyZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Rhbmlz
bGF2IEtpbnNidXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBDQzog
QW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IENDOiBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4NCj4gQ0M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29t
Pg0KPiBDQzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENDOiBEYXZlIEhhbnNl
biA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiBDQzogeDg2QGtlcm5lbC5vcmcNCj4g
Q0M6ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+IENDOiAiSy4gWS4gU3Jpbml2
YXNhbiIgPGt5c0BtaWNyb3NvZnQuY29tPg0KPiBDQzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pA
bWljcm9zb2Z0LmNvbT4NCj4gQ0M6IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4NCj4gQ0M6
IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IENDOiBEYW5pZWwgTGV6Y2FubyA8
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gQ0M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ0M6IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBhcmNo
L3g4Ni9lbnRyeS92ZHNvL3ZtYS5jICAgICAgICAgIHwgICAgNyArKystLS0tDQo+ICBkcml2ZXJz
L2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jIHwgICAgMyArKy0NCj4gIGluY2x1ZGUvY2xvY2tz
b3VyY2UvaHlwZXJ2X3RpbWVyLmggfCAgICA2ICsrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdm1hLmMgYi9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZtYS5jDQo+IGluZGV4
IDMxMWVhZTMwZTA4OS4uNjk3NjQxNmIyYzlmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9lbnRy
eS92ZHNvL3ZtYS5jDQo+ICsrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdm1hLmMNCj4gQEAgLTIx
MCwxMSArMjEwLDEwIEBAIHN0YXRpYyB2bV9mYXVsdF90IHZ2YXJfZmF1bHQoY29uc3Qgc3RydWN0
DQo+IHZtX3NwZWNpYWxfbWFwcGluZyAqc20sDQo+ICAJCQkJCXBncHJvdF9kZWNyeXB0ZWQodm1h
LT52bV9wYWdlX3Byb3QpKTsNCj4gIAkJfQ0KPiAgCX0gZWxzZSBpZiAoc3ltX29mZnNldCA9PSBp
bWFnZS0+c3ltX2h2Y2xvY2tfcGFnZSkgew0KPiAtCQlzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdl
ICp0c2NfcGcgPSBodl9nZXRfdHNjX3BhZ2UoKTsNCj4gKwkJcGZuID0gaHZfZ2V0X3RzY19wZm4o
KTsNCj4gDQo+IC0JCWlmICh0c2NfcGcgJiYgdmNsb2NrX3dhc191c2VkKFZEU09fQ0xPQ0tNT0RF
X0hWQ0xPQ0spKQ0KPiAtCQkJcmV0dXJuIHZtZl9pbnNlcnRfcGZuKHZtYSwgdm1mLT5hZGRyZXNz
LA0KPiAtCQkJCQl2aXJ0X3RvX3BoeXModHNjX3BnKSA+PiBQQUdFX1NISUZUKTsNCj4gKwkJaWYg
KHBmbiAmJiB2Y2xvY2tfd2FzX3VzZWQoVkRTT19DTE9DS01PREVfSFZDTE9DSykpDQo+ICsJCQly
ZXR1cm4gdm1mX2luc2VydF9wZm4odm1hLCB2bWYtPmFkZHJlc3MsIHBmbik7DQo+ICAJfSBlbHNl
IGlmIChzeW1fb2Zmc2V0ID09IGltYWdlLT5zeW1fdGltZW5zX3BhZ2UpIHsNCj4gIAkJc3RydWN0
IHBhZ2UgKnRpbWVuc19wYWdlID0gZmluZF90aW1lbnNfdnZhcl9wYWdlKHZtYSk7DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYyBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gaW5kZXggYjdhZjE5ZDA2YjUxLi45NDQ1YTE1
NThmZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMN
Cj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KPiBAQCAtMzcwLDEw
ICszNzAsMTEgQEAgc3RhdGljIHVuaW9uIHsNCj4gIHN0YXRpYyBzdHJ1Y3QgbXNfaHlwZXJ2X3Rz
Y19wYWdlICp0c2NfcGFnZSA9ICZ0c2NfcGcucGFnZTsNCj4gIHN0YXRpYyB1bnNpZ25lZCBsb25n
IHRzY19wZm47DQo+IA0KPiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgaHZfZ2V0X3RzY19wZm4odm9p
ZCkNCj4gK3Vuc2lnbmVkIGxvbmcgaHZfZ2V0X3RzY19wZm4odm9pZCkNCj4gIHsNCj4gIAlyZXR1
cm4gdHNjX3BmbjsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGh2X2dldF90c2NfcGZuKTsN
Cj4gDQo+ICBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkN
Cj4gIHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgN
Cj4gYi9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQo+IGluZGV4IGIzZjVkNzNh
ZTFkNi4uMzA3OGQyM2ZhYWVhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5
cGVydl90aW1lci5oDQo+ICsrKyBiL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgN
Cj4gQEAgLTMyLDYgKzMyLDcgQEAgZXh0ZXJuIHZvaWQgaHZfc3RpbWVyMF9pc3Iodm9pZCk7DQo+
IA0KPiAgZXh0ZXJuIHZvaWQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKTsNCj4gDQo+ICtleHRl
cm4gdW5zaWduZWQgbG9uZyBodl9nZXRfdHNjX3Bmbih2b2lkKTsNCj4gIGV4dGVybiBzdHJ1Y3Qg
bXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCk7DQo+IA0KPiAgc3RhdGlj
IGlubGluZSBub3RyYWNlIHU2NA0KPiBAQCAtOTAsNiArOTEsMTEgQEAgaHZfcmVhZF90c2NfcGFn
ZShjb25zdCBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGcpDQo+ICB9DQo+IA0KPiAg
I2Vsc2UgLyogQ09ORklHX0hZUEVSVl9USU1FUiAqLw0KPiArc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIGh2X2dldF90c2NfcGZuKHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+
ICsNCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IG1zX2h5cGVydl90c2NfcGFnZSAqaHZfZ2V0X3Rz
Y19wYWdlKHZvaWQpDQo+ICB7DQo+ICAJcmV0dXJuIE5VTEw7DQo+IA0KDQpSZXZpZXdlZC1ieTog
TWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo=
