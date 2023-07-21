Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF675C9B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGUOVr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jul 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGUOVq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 10:21:46 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713B10FC;
        Fri, 21 Jul 2023 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUHnUwfiDbTokbY19UKd/RRbv9crBTo9GHHzvGgsrd+K2PcHpDQMcRyS0qlCQ7FDS6W1/rdfgK1ibxJdBOS59Zhjdy6XAk3fX5XfQXKqT+GCrofxdvecOQManOgRvTgHTsPJ6Ho0Pb4oYyUPcm6kvvdIt6b9jRKPgrw8iMFnTNifOk6IqA+Cf7JzKwg4bEOMYfMNv4W5OlrDBmS9xCBz1esQnzQsTTZNV3YPMsBXi+r1tubgILpH3uy+Thn+3NANBvlT7yDDTDoQWvfd+fgYZec1lcGz5mOyssQiZuLn1bAkzAm+1MdmlG1Xr+1Cv41H/vLcX0TLsivKIwWA+2v1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TFXLsWLP5RCcpNH+JfYpCsc2TAE2f1UjcRiwOOzSoo=;
 b=mzNES5ORJsGZG4TMoKsODpjUd0lX9P1hVVymrsAT9i14VUjGXAzpuFWm/6LJMAinKvwBJGNkMbYcOnvjjs8nUrEEcFzrley7Rs0B4vzmkJcmI62lZ1WIC0Nu/88FZ5/jmo3V5bQh/c7t1lwGV37GQf3qfF0j7fPS1aFu/3CUAic+/OexhuP5Wr7/RpZ8B6bP5lCgdY2mH+KiYkelyvNr194pavb4daWA+JmUaPejRNoMJot615SdAYbwRpLTU3prJVpmG9EwaDIX6IFwlNvNDboR/xyYGTBpZ1MsLmqnIl0AKk5tGgsUOnXSu7wy9Vo/dsqzeWaCe+myNXO4WpPjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TFXLsWLP5RCcpNH+JfYpCsc2TAE2f1UjcRiwOOzSoo=;
 b=LnXr6GiwQMMAwbhMAII1czAjQWDBYUwihjEyuIsnCuBY11Y9uc8O9M4RQbRifqGl1LUlvRtWH+KfEz2P/XbbMTcdefdBb6K8UKIXMIzSmvKNY58NcMGiDvAf4/LW25fFdRkQtAopygkIzrDP4zbDtLhmHULzY192Ul+aJT1TBGA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1507.namprd21.prod.outlook.com (2603:10b6:a03:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:21:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 14:21:42 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Topic: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Index: AQHZu0mXUyEtW9eyqkWnVGF605KOSq/DKCeAgAAzncCAAOUgwIAAAcAwgAADCIA=
Date:   Fri, 21 Jul 2023 14:21:42 +0000
Message-ID: <BYAPR21MB16883A15812E1D20FC28DF76D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
 <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <BYAPR21MB16889A4BD21DA1F8357008FFD73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <533c3cae084f4c2aaf7227e113029d9f@AcuMS.aculab.com>
In-Reply-To: <533c3cae084f4c2aaf7227e113029d9f@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b52301eb-604c-44e1-bf56-29beb984d9b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T00:20:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1507:EE_
x-ms-office365-filtering-correlation-id: 617b7e72-852e-488d-30a3-08db89f5ce39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kgPBr7ng2MnLduMb2399y7tl/+ByC6wdD/PryGVg6EoWWNOhMfGQIHJwvh5mjZm2TorQExzNtdKCpTMQa7uZqWWxiXdojK9RDUNzo4BLZs87qYcGcR7d3BLR8id+kKuq13g7zhfVcAjRO09p+PJyTUFofwfRdZQslFqCZ6Jaj/M6Ah2fE711wzTQNhqsmi9SOFQhbrU7v2FoTVv7i/+YmBDQCfcuxf20h4n/kfX7ENMuPXLr7lr7hCZ5Sv7aVVIHHpv+kBCcV+UXEd87Xrw6ch1EqE6+cv/Xde2TXJ2QXsrLH8b/BlRGG0A1g0IgFs3zXmhgMOZ/UTymd9r3QzQLB7aK6x0l+wi4HEou9l4e8KQ5/c2a6i36sFWnBmvFUZpgXm7Atr8C9Xvxy3hSsGd7y33kkR+XhWwVYwPVm0ck2cxCs6d/YSr0yGKGfIL9BuwCEeNkt6SXiahS+74jxAUkpjxZ9Eh7B31ub0/0mmnvTKnzJ3PSE1lZChQyavyFe1bqjfmWrpe3nDWL1CQCdmmWiPn7jazqEA/ABIlbG3c2THqQB659rPMSPBbUzbIAv9zORtbWx78I6UCHXNpConkUC+ELbX1hdDsy56B2/WQdI9y4KMqq5C5pqEBTEC0JV8Z9LlHHKp2/RoF7xq9LQA2UpRDOlHf6wLoKYPWUqRC2tQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(6506007)(38100700002)(82960400001)(26005)(122000001)(8990500004)(66446008)(478600001)(8936002)(10290500003)(33656002)(86362001)(7416002)(8676002)(52536014)(4326008)(41300700001)(66476007)(76116006)(66946007)(64756008)(5660300002)(54906003)(110136005)(55016003)(316002)(66556008)(71200400001)(7696005)(82950400001)(186003)(38070700005)(2906002)(4744005)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUVuRGhoWWc3bEhaeTUySWtlZUNXN3Q3NE00Z215U2FZU0JmYm5mQVF0Z2lu?=
 =?utf-8?B?cGZkajdjQlFWdWh5UzJ1K091N2NqckEvWVBFYXU3djFDTTRPNEJGSTI3Mld2?=
 =?utf-8?B?NHB1UXBqL1hjc0pVZjNBZ2dYMFlEYXFnSzJpN2QyVTB6YTF6ZGMrOHZyMDFL?=
 =?utf-8?B?Q2tMNGlac3dkbWQxamx5L2tWMkZUa2xlK1FSVWpWTnlaMWhzOWhEdjg3TDBI?=
 =?utf-8?B?clVXSHJtT3RWMk9TZGh3ZU9pZDRuNW5JTXNMQnVIR3NIMXN2Tld3V2x3Vkpa?=
 =?utf-8?B?Um4zSnVsMzVSbU8zZjFrbURQRk1wSklsalE5V0x4TE93VmpCdk1HSzIrY3Mw?=
 =?utf-8?B?ZXRiaUNoWXVjbHo3ZHpOQnczWmdUQ1JiUEF1NUpRd2Nxc0NNQm13TVdJSWVZ?=
 =?utf-8?B?eHpsQlJVQ0hxNTczVXZOYzdJd3VwOWZGL3hocEc2dkZyT0ZRajlyM2pmUG9k?=
 =?utf-8?B?L2R0clZPSEk5OU1qRGJ4L0VXdysyZWNDUkh1TnpOZmw2dlJ2NlM2REdTUWJG?=
 =?utf-8?B?ZnEzdHZjRmFTYXVOOXE5eG9NeTU2UzJyL2VUYWlRZDZLeXJoais1bmlsVVN5?=
 =?utf-8?B?cTlxUnRsWkU0czRGdkg4djVMVXZzWkVMWXNoa09ucGdmOEl2T3JkRnltNDFT?=
 =?utf-8?B?dU1XWTlkbFoyM1BKcHR5TkFWdUxyY256U3o5QlFaRDVCUEc3S3M4UktMY3pE?=
 =?utf-8?B?QVZ6a2o5eVdBU1RXemlaN3FVbGVXT0ZiUVV1ajYyTUZSZ2NtdDhhdDJ2ems4?=
 =?utf-8?B?YVNlQVFHUkNGekpENVY2U1Z0cmt1TjJqVE1ETUFpTEpDVlhEZDFhNG9lWHp2?=
 =?utf-8?B?Z1BNYzBwcFJ0d1lkQ0pSRHJjWmJPaHZsYXRrN1orN3BXM1dVeE5Ra1J1N1dG?=
 =?utf-8?B?bkNmOWZVenozdnozc0FRREE1aXBLbU1NK0J1TkI4TG9ib3hnYk5nT0RYZi9Q?=
 =?utf-8?B?blZtRElrYURwaDZkSXBlOTh6S0c5OWdZcVhsem1ITkQ1MCtMUTdSSTJCc1ZG?=
 =?utf-8?B?S0p0VCtLUEE0YjhFenk1cmRpMytKTURwei9oMGVVQ2pxeXdCbWZzNStNRGQ5?=
 =?utf-8?B?QTRPVWVDTHU2VHNaQmhnMVhvOGM1dHlSTUU4NnFJbDJiOGxueTJTZW5veDlZ?=
 =?utf-8?B?Q0J1aTZEVjVkNWF1YWJVa0JLVEhocXRVdTRjZnR2cG4xKzJqQ2Jja01HVVRX?=
 =?utf-8?B?YWdHWHlsWU54cmJ3MVNiaFkyQWp0VUVVbk5GM3Vsc0lGdGcxREYraTVGMVZL?=
 =?utf-8?B?c0NBdVByTXp6MHlIWENJSGM5N09LS0QzeDUwQTR3YmF4dFFNUUI2bUJDMkc1?=
 =?utf-8?B?L3pPb0NOV2RhQmx6Mjd3Uy9DSUFhTERkY2dUNGRJaTlFQ2N1WGxuQXAwM2tO?=
 =?utf-8?B?SXlFTzgwR3QreFVSMFI4VWFud3prR3V2NzVNM0ppVEpNUXJsUWJXcE1VKzNK?=
 =?utf-8?B?NkN3K2MxMHpJTkZmWkwvSGVIOGIrblhHL1JnZzRoMGVIUjdCZ21USnNJWWpy?=
 =?utf-8?B?VkNaMy9NOW8wVzBleGZiM3NsaGYvSUxkb2p6RndoOUt4WngrQ0wzWHVBY0lY?=
 =?utf-8?B?dFY3N2wzbVJlaGZPZFppbGk5UGpSWHErTHpUQmlWOWRVUXNVb3VqWXF0VFVy?=
 =?utf-8?B?QkRwdWRPNGZ1eGh5V2VIb3lyVkJnSWhRd0NwK0ozSW9rNjd6djVmNE9pOVNm?=
 =?utf-8?B?ZTcrcCs4bnF0UTN5cVVxZ3Y2VUw3cndoN054SlFNUWd1SmVzOUFRNDBxZUJ6?=
 =?utf-8?B?OGY3MUR3UHlBWGkweTYzUStxa0djbGZMQnZ3M290WFQ1Uko5UnlmTUdKS1NU?=
 =?utf-8?B?aWZoVm1kanZVSmlDVCsvWUhWRFE5aU9ldEJmT3JYV0dpSjk1MU1lK2pWK0Nm?=
 =?utf-8?B?WWFYaWNWR3BtRkQycTU4MENKQUYrMHJoeXBkWGlzdzdjNFhtdTJPZmRubzI1?=
 =?utf-8?B?WEZObUpsVEw2RHFYV0hpS2V3U1BaVDVIT3dMR3FRdDA2NlpuMDJTb0Z4Mzdm?=
 =?utf-8?B?YU1mWW9wLzJHUUtkb3Yyd0RQeStPS1M3c1pZbnZkYlVnSkxPUHZhdEJhTVJq?=
 =?utf-8?B?bXpsVnJKZ2QzMGtoOUZHNTlkc0dQYWZmZzZONXEvWGtWdlM2bXhEaWxDYTJn?=
 =?utf-8?B?NlduaE1oWkVKazU0VEE1Uzdya2xJVERtOWhXVnRaM044dkJ3OHZJYkZ4TmFZ?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b7e72-852e-488d-30a3-08db89f5ce39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:21:42.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpJvpHkOYBZFEyb4kp0gNRq0rlBy6LNb2Sub5X7Jt89NYfLX53e+L1HzRHaFeixt1U3W06E7ncX0J+claN466uofCtw0A6CT7J0783GtcPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4gU2VudDogRnJpZGF5
LCBKdWx5IDIxLCAyMDIzIDc6MDcgQU0NCj4gDQo+IC4uLg0KPiA+IEkgcmVhbGl6ZWQgaW4gdGhl
IG1pZGRsZSBvZiB0aGUgbmlnaHQgdGhhdCBteSByZXBseSB3YXMgbm9uc2Vuc2UuIDotKA0KPiA+
IHByX3dhcm4oKSBtYWtlcyB0aGUgbWVzc2FnZSB2aXNpYmxlIHdoZW4gcHJfaW5mbygpIG1pZ2h0
IG5vdC4gIEknbQ0KPiA+IGhhcHB5IHRvIGNoYW5nZSB0byBwcl93YXJuKCkuDQo+IA0KPiBQQU5J
Q19PTl9XQVJOPz8NCj4gDQoNCnBhbmljX29uX3dhcm4gYXBwbGllcyB0byBXQVJOKCkgYW5kIHZh
cmlhbnRzLiAgcHJfd2FybigpIGlzIHVucmVsYXRlZDsNCml0J3MganVzdCBrZXJuZWwgbG9nZ2lu
ZyBsZXZlbCA0IHZzLiBsb2dnaW5nIGxldmVsIDYgZm9yIHByX2luZm8oKS4NCg0KTWljaGFlbA0K
