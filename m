Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D2616D3E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiKBS6F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiKBS6D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 14:58:03 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022015.outbound.protection.outlook.com [40.93.200.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E085010B64;
        Wed,  2 Nov 2022 11:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kctLgMK3JbCewfKxstLnrkGotX18sGs7uuK9TSXzyshE6BU5NvIpDx5trkJskaZlEZq5Tk0WV9GQ4FGIgHeB74gJpelAuNWmiKPgV8QxBJtm/dq0ubbvvNxubbHTE9iiQpcroQKUF6y4LRtBWUVVGeOpCWU7WEY220lFxoX1odOxwzvl7qLkHD3ImKjUydPscUf9ly9rfriZiuVmxPKsIk9mSnB0xVbwHZK/Aig6uPpiqkqwLFJq1pt8S2UTe50Fues/PpGRdOjz1cOKdGnFvVNkAfqzAEWGwCyqvIZVp9F0FxvZWjIWaDW0AsdOZuFsZrf8s4tAvHtV5x2+8VTQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzTioAHPsJUulHW3xjw1DsGsnCshkIiZBerYSMmfbz8=;
 b=cUstfvY7DJ/+5ySNYoVzDEmUjNrYBAo1FaF/dcflxdHVA3V+Na28/aE2t3hxL/gDbnRMb8x23udkaNeJAhAATLRGMZzs2qPpcASJeSiTR0KL+HB/XXA5vZfikD32loVMIbmze2inGNgxBW8WgctvrXfLjXLdG4kpaOTwom+ICgtintynt+WAPmXD6NOjqHoKqiFA+/qbIFb7LOqoukBJHD7p7QaFI4WBkPBwpnqQjvSGMZ4u1mYVFle34dsx4YFd9EQFljg641XDXppOw/lb/y0f+VxLnU9xBuxD0k+NRm6OagFihCRzKIh0UEfuh9sNCEsUPqtD0QZih5e4E4zozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzTioAHPsJUulHW3xjw1DsGsnCshkIiZBerYSMmfbz8=;
 b=XL4cJ/1bs2pQpXE/68oUAq1t9bWUCo7hrjEMrUkuudVUljYtMNOfJJudN4vTVhyfQY6SQPENDPNq9xlVzflE2cc05S8ULJD+kPd9sUxO5s+rKMMjbppPdF1rZ7bcjUKeoIn2Hi5VP/LhWVcgEakEhK7zWxdDr6Y2iipXx6k5ZiE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB2041.namprd21.prod.outlook.com (2603:10b6:303:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 18:57:59 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 18:57:59 +0000
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
Subject: RE: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Topic: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Index: AQHY7hfGdFg8W+TW4UePjgHc2LBts64r/ZcQ
Date:   Wed, 2 Nov 2022 18:57:59 +0000
Message-ID: <BYAPR21MB168811CDE949BAA2BCB69B56D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=555c3afc-0a5b-4544-89a4-4202776e91e5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T18:57:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB2041:EE_
x-ms-office365-filtering-correlation-id: ffa1b1a9-b84a-493a-04b0-08dabd042961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kngaEuevgHkYqJEmqq1TmySm4VkMQ25/lTKJYI+VZ49+X+LIBMOaBNtJIsUoxTXCkbX7av5VeBm8Xg0DDLZzCfdaCwlHh/U4Ovme007tiIpdKr0UBsKNLe5Dai8YEiRe90Ws60eK6oEYgtltWpgAy8+Z8pjIquLRvyl5hyiph2c8PFeWogTQ5HG/SIxuiR1btcEW81uARMATj5gFGjArrlq8L/RnvJihvBN4Ydgn2zEViv2/PGZ3sGT9NJlQXIpFB/D1WyT9mEI+EDvKJCFbcBoZ0OLDiofPaBEggJzUtiVng2gXAB2juoQ1gwKZXc29OuroI+M1yJEF+cIEH+2pUtKawIC3igCzbyegbAODRMs/oE6pRhCljU+CW4EKcUvCKWShMMNmhVUbItCyjUBnrmmlLRkVbSRpQHmBxp4mdhSeuwIV/b5afPbIx2TTzda3cHn8y59ZaNegRDAy0wF7ubun3BEagqCRuj2JjnuJQWzZ9jjOlOY1qPaiz8ueMdRBubM+mkx31QMt0w2MBjFbJBE6b/4MK5B6eE/zYyBB84AXciSKIgEDy15tVb8DVWe+4wjQFF3BQmawbQcWYBblC/xUJE2pG0/087xCfIrjJ0yAW0QG+fJs8U39ygpJHY9Eza/BE8E5qTkoAk8GMyd/ZksJVz39dVy5/V+dTdcKcQKB2R1tSLVxKYMWMQ5M+tmPrfRVDiGESQ/JpkEnJUfMuEi8TDTEfCDuctY4H3pi3VZXhH4oSucVYOtpUZy9tOkmT2VbCjYpLcHi3NWB9qOamxFoI3tHuIIKWV/qSE3A0FyDtsTbzg7J6P7RtUkGtGbE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(54906003)(186003)(478600001)(76116006)(66476007)(10290500003)(8676002)(4326008)(71200400001)(66946007)(26005)(2906002)(41300700001)(52536014)(9686003)(66446008)(6862004)(8936002)(83380400001)(5660300002)(66556008)(8990500004)(55016003)(38070700005)(38100700002)(64756008)(316002)(6506007)(7696005)(122000001)(86362001)(33656002)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K280cEhHNkZPdzdPcmhSQW0vSVR6UWZvd29WVjAwN3VjTGRLaHBXMnladEUw?=
 =?utf-8?B?TGtKUDdzV3VQTVYyeENCbms1ZmNiWjh2MjJDYTluSTdJN2JkRlZtYXhVU1Nn?=
 =?utf-8?B?Q1NFSUE2ZzFuTHdkS3FLcEl2NW44Nmk2eGg3Z2hkU0dDZURJNm0rYmpOSkJY?=
 =?utf-8?B?dER0M0ljK1Z5R2QvbGtvejdZOXpGZ2Q4OGUzaDBlM1BOT3M0cm50OVZ0UlZC?=
 =?utf-8?B?Q0xKQ0IyazZVWTVuaFFoWm1TR2hERzN5eUJ1REl1Q3hVSVhtYlFRUUV1ZHla?=
 =?utf-8?B?bk1YNkxRS1Bwcmw4Yjhrc095WnJoeTEwUzVUU2JyaDRrYlMvZzlPV1VUQ3VF?=
 =?utf-8?B?YTUxaFFUS0ZuK0t6Q3hiZDJKVG80anhoWFhQOTdlbUZoTzFzN1VVeHpPN0U2?=
 =?utf-8?B?ODIwVzlmVkZ1bURxYmZpRytxaGlTMm0rSC9QNWppTk1mb0M5U1hKUThUR0J6?=
 =?utf-8?B?RU5sREZIN0VMNXk4eGVTRzBmUHhaRGI5dzM0WXlMVExCRXlac3l1SXU5SmJl?=
 =?utf-8?B?MGgzQ01iZk5wZjBwVkhkcDRuMk84QnJtQlhDRVZxSHNiYTJQd0grUHBsK1pL?=
 =?utf-8?B?emZUa3FNK3dRS3pqUWVPUE4reFRHaFRwYnlGMFhndVU2NXdHMTNXOWtZUHZP?=
 =?utf-8?B?aEJ5d2laZGxCTHBlL01NZ2Y5WFdWMHlpdFVnRDdMQ2xPWDlXVXhWM0NqVkhs?=
 =?utf-8?B?ZE9yM3BzeHVxZXk2Qnl0VzZ0eXlnb2Vsc2I0LzBTNVkrUXRLUFJIQW40dExM?=
 =?utf-8?B?NGRuaTZ2aU42VFV6RFFTMHlCUHpYL1plcjFQZjRydlBOaXVFTVVjczFGM2lv?=
 =?utf-8?B?dUJWRG5paUp0OS9ZeTRiM1RQZXFUM3FDU2o4b1U2QXhDdDdaUGYydTE3OXFs?=
 =?utf-8?B?YVpnL0VucUZGc0JZeC8zUWc3dzZWbzA0WWtmQXhWK0JiWXdtdkFtdGwzcWRT?=
 =?utf-8?B?SVhQcFBtcVVLeU1NeEtFcXIrY1JBOTZBRjJ5SmdFYlROWjh4cXB2aVN4WkQz?=
 =?utf-8?B?eHR5THpJODlGTis0L2VibG9nZWtTSUJKZURqUlF1MGcyTlA1MlNvbldsVERQ?=
 =?utf-8?B?L21EVHlrUHNXNzc3MjUvaUlPb0NHVzF0ZW1wN1h6cUZpWFViNWZ3NmNlcDJB?=
 =?utf-8?B?Sm0yWklPUWhUUTQvWm5ueE5mSGUwSmNJcUtoeUozcWlBbGNaTi81UXhSeHZq?=
 =?utf-8?B?dmV0dUdBQUJQQUtNQzcybTJ2R2FLMHJ0bS9sZkxMZXlkcmZoUnJySks3SkdD?=
 =?utf-8?B?eVhRVk92cUlPbU5JMUpTQTdDVGpvZllXeWpmYlk5VGJaR1VaZG9uVlhjNmxi?=
 =?utf-8?B?NHZiUk5BV0Y0bUNsejBvV3ErbnJaRjUveGFNcHlpdHVVNGZkN3lScys3R21v?=
 =?utf-8?B?ekZkK3Z3TmJHeU1QdVdlVXhIR1FZTEw2NnM2KzEyZTNwS1pIRG1OSzZ3bll3?=
 =?utf-8?B?VTJCRUN2RXJhOHdObzVOZHV2OUpOREsyWWNIeGk2eXlpMUFML3g3cm1aeHRN?=
 =?utf-8?B?RHNBU21Jb1Yva0pKYVRPRlRtS0prbjNyWUtibWxJWGtDSnFpMkQ0eTZsN1BT?=
 =?utf-8?B?a1NEeVN1NjFRblB4ZzdUM1Y2d29oc2hiMERudXMxMGJ2N2ZSS0R1M2dObUs0?=
 =?utf-8?B?cEsrQ09raW1LYWRRT3JQUC84TDRVODQyeUEvUS9xQTZQQngzdjRxQU5mNDZm?=
 =?utf-8?B?Tk82WjY5Y0kxalVJQStBVWUxNEFGSmhqMHVTZDZnQ2ZJR0dWTzRxc3NITW9v?=
 =?utf-8?B?T04yV3Qydloxa3VSUzZSaVI0dStVQittS2xCQ3pUYTlUT0JCZFhSclV0Y0F0?=
 =?utf-8?B?VEg5Vm0rSDd0ZmdSOVNlQkxTL3FQV3g4WjREdDExSExJeVhGOTg4NnRFVU9q?=
 =?utf-8?B?Nnc1WWhvRVNOYlFIRmhreFc0VzN1U2srSUVPSjBMeVlSVmIyZUtFak1zOU9O?=
 =?utf-8?B?TGY5eVBOTC9YTG9vdHRWMndaUGF5czlZdnBzTUx1T3pSZVgydFhYdjNhZmlt?=
 =?utf-8?B?enpDK1htRmFzNWtOSnFDNFpUQWIvL2NZd2p6QTlOVTFvRnhXaXQ1S09DbFMr?=
 =?utf-8?B?R29aL2k2UUpsZTJZRExDT3ovWFhHL0w0Z3BLQ29rU2tseHowK0NkU3I3SUw0?=
 =?utf-8?B?bk5NUmpWRWRMaGtsWmNVWVlJcW8yZTM4YmZCMTJRK3pDZExlLzNuOWFsb1Zp?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa1b1a9-b84a-493a-04b0-08dabd042961
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 18:57:59.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxZfxVU9k1uciGr6QszDeeACLXkgJxtQF+Q1i3S7G8983O5+Mb2l3WugWuWiwqA6jzEj5rBZmgp11ZKYx46irjAkU2a+FzQmpCUs38+pepc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2041
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
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMSwgMjAyMiAxMDozMSBBTQ0KPiANCj4gQW5k
IHJld29yayB0aGUgY29kZSB0byB1c2UgaXQgaW5zdGVhZCBvZiB0aGUgcGh5c2ljYWwgYWRkcmVz
cy4NCj4gVGhpcyBpcyBhIGNsZWFudXAgYW5kIHByZWN1cnNvciBwYXRjaCBmb3IgdXBjb21pbmcg
c3VwcG9ydCBmb3IgVFNDIHBhZ2UNCj4gbWFwcGluZyBpbnRvIGh5cGVyLXYgcm9vdCBwYXJ0aXRp
b24uDQoNCkFnYWluLCBhIHNsaWdodGx5IG1vcmUgcm9idXN0IGNvbW1pdCBtZXNzYWdlIHdvdWxk
IGJlIGdvb2QuICBBdm9pZCBhIHBhcnRpYWwNCnNlbnRlbmNlIHRoYXQgaXMgYSBjb250aW51YXRp
b24gb2YgdGhlIGNvbW1pdCB0aXRsZSAod2hpY2ggaXNuJ3QgY29ycmVjdCwgYXMNCkFuaXJ1ZGgg
YWxyZWFkeSBwb2ludGVkIG91dCkuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBL
aW5zYnVyc2tpeSA8c3RhbmlzbGF2LmtpbnNidXJza2l5QGdtYWlsLmNvbT4NCj4gQ0M6ICJLLiBZ
LiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+IENDOiBIYWl5YW5nIFpoYW5nIDxo
YWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiBDQzogV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3Jn
Pg0KPiBDQzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IERhbmllbCBM
ZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBDQzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3Jn
DQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9j
bG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYyB8ICAgMTQgKysrKysrKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tz
b3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gaW5kZXggYzRkYmY0MGEzZDNlLi5kNDQ3YmM5OWEzOTkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gKysr
IGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KPiBAQCAtMzY3LDYgKzM2Nywx
MiBAQCBzdGF0aWMgdW5pb24gew0KPiAgfSB0c2NfcGcgX19hbGlnbmVkKFBBR0VfU0laRSk7DQo+
IA0KPiAgc3RhdGljIHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKnRzY19wYWdlID0gJnRzY19w
Zy5wYWdlOw0KPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgdHNjX3BmbjsNCj4gKw0KPiArc3RhdGlj
IHVuc2lnbmVkIGxvbmcgaHZfZ2V0X3RzY19wZm4odm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gdHNj
X3BmbjsNCj4gK30NCj4gDQo+ICBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNj
X3BhZ2Uodm9pZCkNCj4gIHsNCj4gQEAgLTQwOCwxMyArNDE0LDEyIEBAIHN0YXRpYyB2b2lkIHN1
c3BlbmRfaHZfY2xvY2tfdHNjKHN0cnVjdCBjbG9ja3NvdXJjZSAqYXJnKQ0KPiANCj4gIHN0YXRp
YyB2b2lkIHJlc3VtZV9odl9jbG9ja190c2Moc3RydWN0IGNsb2Nrc291cmNlICphcmcpDQo+ICB7
DQo+IC0JcGh5c19hZGRyX3QgcGh5c19hZGRyID0gdmlydF90b19waHlzKHRzY19wYWdlKTsNCj4g
IAl1bmlvbiBodl9yZWZlcmVuY2VfdHNjX21zciB0c2NfbXNyOw0KPiANCj4gIAkvKiBSZS1lbmFi
bGUgdGhlIFRTQyBwYWdlICovDQo+ICAJdHNjX21zci5hc191aW50NjQgPSBodl9nZXRfcmVnaXN0
ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQyk7DQo+ICAJdHNjX21zci5lbmFibGUgPSAxOw0K
PiAtCXRzY19tc3IucGZuID0gX19waHlzX3RvX3BmbihwaHlzX2FkZHIpOw0KPiArCXRzY19tc3Iu
cGZuID0gdHNjX3BmbjsNCj4gIAlodl9zZXRfcmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNF
X1RTQywgdHNjX21zci5hc191aW50NjQpOw0KPiAgfQ0KPiANCj4gQEAgLTQ5OCw3ICs1MDMsNiBA
QCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgaHZfc2V0dXBfc2NoZWRfY2xvY2sodm9pZA0K
PiAqc2NoZWRfY2xvY2spIHt9DQo+ICBzdGF0aWMgYm9vbCBfX2luaXQgaHZfaW5pdF90c2NfY2xv
Y2tzb3VyY2Uodm9pZCkNCj4gIHsNCj4gIAl1bmlvbiBodl9yZWZlcmVuY2VfdHNjX21zciB0c2Nf
bXNyOw0KPiAtCXBoeXNfYWRkcl90CXBoeXNfYWRkcjsNCj4gDQo+ICAJaWYgKCEobXNfaHlwZXJ2
LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVSRU5DRV9UU0NfQVZBSUxBQkxFKSkNCj4gIAkJcmV0dXJu
IGZhbHNlOw0KPiBAQCAtNTIzLDcgKzUyNyw3IEBAIHN0YXRpYyBib29sIF9faW5pdCBodl9pbml0
X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCX0NCj4gDQo+ICAJaHZfcmVhZF9yZWZlcmVuY2Vf
Y291bnRlciA9IHJlYWRfaHZfY2xvY2tfdHNjOw0KPiAtCXBoeXNfYWRkciA9IHZpcnRfdG9fcGh5
cyhodl9nZXRfdHNjX3BhZ2UoKSk7DQo+ICsJdHNjX3BmbiA9IF9fcGh5c190b19wZm4odmlydF90
b19waHlzKHRzY19wYWdlKSk7DQo+IA0KPiAgCS8qDQo+ICAJICogVGhlIEh5cGVyLVYgVExGUyBz
cGVjaWZpZXMgdG8gcHJlc2VydmUgdGhlIHZhbHVlIG9mIHJlc2VydmVkDQo+IEBAIC01MzQsNyAr
NTM4LDcgQEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nrc291cmNlKHZvaWQp
DQo+ICAJICovDQo+ICAJdHNjX21zci5hc191aW50NjQgPSBodl9nZXRfcmVnaXN0ZXIoSFZfUkVH
SVNURVJfUkVGRVJFTkNFX1RTQyk7DQo+ICAJdHNjX21zci5lbmFibGUgPSAxOw0KPiAtCXRzY19t
c3IucGZuID0gX19waHlzX3RvX3BmbihwaHlzX2FkZHIpOw0KPiArCXRzY19tc3IucGZuID0gdHNj
X3BmbjsNCj4gIAlodl9zZXRfcmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQywgdHNj
X21zci5hc191aW50NjQpOw0KPiANCj4gIAljbG9ja3NvdXJjZV9yZWdpc3Rlcl9oeigmaHlwZXJ2
X2NzX3RzYywgTlNFQ19QRVJfU0VDLzEwMCk7DQo+IA0KDQo=
