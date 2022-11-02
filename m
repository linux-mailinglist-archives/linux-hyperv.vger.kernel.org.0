Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2412C616D3A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKBS4r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKBS4q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 14:56:46 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021026.outbound.protection.outlook.com [52.101.52.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DBCD6;
        Wed,  2 Nov 2022 11:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7wdOxAIohX6Bfl/BxNLabI3IhY0Ig7aSfVwTEVh5jOKA2PVkB3zDl1QV8IWrLC0aPyC4fav+Kvp2e/pltup/HQlIZxp06BR+B1ZwT5YneZeV9lJqOzmsDvP5U3xj7MUc5zrLX8vfbTu0/0FRuXB7b1FJscwBt+8I9AUgUvFPJ/MFQJiPB0MryPs53++xxSptOK4ulw1IS2IWmzZaG1S1f/F5bNPSKg+CFGwqhJ0OjUZJCMjTCQYFv5GOkuHbzGho4sx1Db5NGoNr/uwtrMenZLUsoue7SdWXGKBxj8cYlvXCk1stTvjyBKVPvhhWrQigOmmPl3w87DE2hEdiUTu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubpyvQUUG23danFVCAhoQIXjafEwEHOBi3VQMEDBL50=;
 b=A8nNOHSOtcbwEXQPVmUbFUgixecAGLeJRalN19HZzo5nMVmtLFT/jWajJiCHlk0AXjENRIZYD+KoZALIm76cwrvvHDgceILjNjj9ygQJwqcHO7Em8sTnw9oea4JLYGr5GBLYxlz9d0D0/Vfu2BTNXjbMCb4sGv6vuwb0q4z4Lj2auiPEG18g97qplC76nta29a/HK3081XNZYiPtPsqLnUVJfNVxdW+xKJbpU5KEfIUQ6iN8kFFdh2Yl39eezp5e3omLF73EzD6YWlWBITi4lu5F5poTLhUpgBEYMBJv72drpmWJh6FGaeLcGvjsgTWCD6V6r6etPUbhYe5XcqjcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubpyvQUUG23danFVCAhoQIXjafEwEHOBi3VQMEDBL50=;
 b=fkpZgI6/PnVYJz4EZD/pUo8skixm23MSQPWKn6kaWFTx2KnC45mkKeC5F7mJjCCRDoJudcWBlCTRBNc0EOYJQ46aZE22s10iu3wUNeYp+ti+b7O6vMmES2Bgutch2a5DDThN3e7tA7FU3SvJcSEPmIDOvD5TxLpM7sugQ6Sv/ds=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB2041.namprd21.prod.outlook.com (2603:10b6:303:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 18:56:40 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 18:56:40 +0000
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
Subject: RE: [PATCH 1/4] drivers/clocksource/hyper-v: Introduce a pointer to
 TSC page
Thread-Topic: [PATCH 1/4] drivers/clocksource/hyper-v: Introduce a pointer to
 TSC page
Thread-Index: AQHY7he/duewECSvK0C3ncRhEYtCRa4r9x8A
Date:   Wed, 2 Nov 2022 18:56:40 +0000
Message-ID: <BYAPR21MB168821E469CDBC3E6BD171F0D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386464.9827.16622091938453285710.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732386464.9827.16622091938453285710.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=008db786-af16-4c03-8931-b41db7c5cd78;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T18:33:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB2041:EE_
x-ms-office365-filtering-correlation-id: c2d9303a-0f58-4dc5-12c7-08dabd03f9e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9liVG1opN32NeZIZQLLeoMi7OMK+s+0RxPlNs/1dwS2d55FNcftenw6kyqb05G1PHm5nMqrG4FtuffTgN1AWwd2LjYM5zft3Qq+eWeiR6VI9cYSRV6LHwaKnWsOSH5MgJlfS3qVyHjLAh4xM9JnhVv1YMM8gKbFV/W3r16TM7zxn8AXLg8mSllCNWrMGETezaJVOh3ny1wasTX1g5i2z4+j3U5SoCaz35MzUrqdZ9LVG6Vx6q9ewpKiaX6k7hMbAqQP6sXkUAHzQEgSpU6kh2HGl3ruaDuj+aeQAk8HE77WK0qS6o14yh4ZWsZ3YitEv44QUF9okc6DNaYVOVS+0c8obPM7x6tEqc6O+F4IeDi0tlsfL8R93k/IIfw4GMR3vRyV33dWsVdktFb7Ml8lr1iIYgBJAucJVtk0t4pMDcJz3pKTi/oMr/nJSMdGmYqqdHODf8c3rSvZ+GbEyBTJoyh/oVk+HjhXcZziUcA9FSTNOH8K4qfLaTGvupbuA5Q9hBCU5d9hXmeMRRJGnphAOFkH3gmA5euUg1+/8bcaPlHhrQlkO62DLDrg/ITRYGh03HaX4rma/t3jkq4Np6ggvJMox1SLwRmE5tsEp9vGjXU/AWyOHQpIAwFKC2HlknRpGM+yB0NEJkBFWIiP4e69Cv62IJNJWAY5GUPxiANgTN9SBKaEZlqRCpJnryy66rbW+3I+TcVuX+Br+HK7BBdvfELOLhs7b8LTHgqod0HLq2WZWuMW5ymo6+GEACSr8wa8pBnswYyo9QBZhNTljL8M/N7QfjOCHVuD9nUV53PqMjGZUCJ1DUvgAeATZFWzr3dM2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(54906003)(186003)(478600001)(76116006)(66476007)(10290500003)(8676002)(4326008)(71200400001)(66946007)(26005)(2906002)(41300700001)(52536014)(9686003)(66446008)(6862004)(8936002)(83380400001)(5660300002)(66556008)(8990500004)(55016003)(38070700005)(38100700002)(64756008)(316002)(6506007)(7696005)(122000001)(86362001)(33656002)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVozcGxSWE9iZjBtSXhFSDJFRFB0RHY5bll0ZS83M3dSazZmdmErMW5iYU9x?=
 =?utf-8?B?NzRldHNGN1locDkwWENPVlcrQ2w1YStwcXJlYXR5TGdKdFdkU3NNMVl5elRo?=
 =?utf-8?B?cWFpK1dTTHBSOHFMQ2xaQkpnRXBrVE94bDBiOWFSYjBUZmRUR1JIbzk1RERH?=
 =?utf-8?B?aldxTCs2Zkp1SEhnWHZRUVV1dmZIeWIvSlhCd0V2UTNhc2NnbVV6K0w0TElV?=
 =?utf-8?B?YStxQXlvckkrK2d1WS9DZmhHSldtVkhtRkJVTGdCSE1paCtHcEZiY2w4Y25H?=
 =?utf-8?B?MWIvTExjK2NPSjlULzJrVFlxeDM4UmovSHhkWVRSbkd4cGZwQVFzdG5aQklQ?=
 =?utf-8?B?YWlXRTU2LzdEUEs0ZHliNGlRWExQUy9WbjFEZXk5NVJXcGRZSGFHZ1J2bjFl?=
 =?utf-8?B?dmZTajhEVVQxN1pidlNtK0pMYWVVTHcrWWVDSVRuVG5SU0RrNmEwRXoyNXZK?=
 =?utf-8?B?QXFENXROSUpuWnNPbmVBNFM4TE5uVHFwY1p5dFNJKzlnWjlRV0MzeWltR0lY?=
 =?utf-8?B?Q3pkUEN2WlE2ZEJMUVdGRmdQRWgrYlBrVmJlckNEb2ZYQWdGQnVBenBUOXJk?=
 =?utf-8?B?VFEydHJKNGd2aDRWVWY2WlJTNW9QS3NkVzY1K04vSzRHdFExMU1RbGw2aWpB?=
 =?utf-8?B?R05SSnIxYzlYMTl6ZTNtRjNacnRScUxVYzNyRWc0bFp0cVgrSDZwZDc2T1Jy?=
 =?utf-8?B?YmdTTFR4RFZCWWw1WXZoQ0JwaE9BakNDKy9NaDhpUmNCOEpmWlhNNmNJc3Qw?=
 =?utf-8?B?V29jZGNYTVZYcVRITVVGei80cXZDZy9Yd1dzNFJpMWgxbDdOVEZLdDhOdWUw?=
 =?utf-8?B?SVlRRGZnTHBZOG14cTdzRGR6QUZjSHdINTZBcGVvVFRObk9qOGFBUlFIamFo?=
 =?utf-8?B?ejhtZUM4RDNINmpxaHVlcjdVL0ZVcnBBektsMmRmS00xOVBVRDd0MWJTNGVu?=
 =?utf-8?B?RnN5K3VWUUFZcjd2SnZFZU8rSE9FVnpWQXhsaGF3b05qS2pzYzdXUkRaTDBP?=
 =?utf-8?B?UFRyaFNhVGtFYzZxTHIxZHF1NzF3dEtlZjlCbVJRUFVPTkI1MHgwWVdsNHdh?=
 =?utf-8?B?RW5EdzdNbDFBN3IvblhrZVBMVzZBSjd2aGF4VUZIZ2ZnVTRscG9ydXlZZnVp?=
 =?utf-8?B?ODk1M0hxV0NrbnZVK05ES3ZDNnpTSkJ0Sys1Wk5SLzBCeEk5OFRVcWViZk8w?=
 =?utf-8?B?M2JZOFZJb0EvY2JWM0ZTR3Y4U2dzV1luNldKbS95VzVjWGVEbUh6U1U2TDNx?=
 =?utf-8?B?UmphZUhCTkdEWGkzRjBSeW9LNG1QVk0wNDdMZjE3T2p4U3crK2I1cnM5cE5G?=
 =?utf-8?B?UVNiNFc2dHFoNHN5dEtsSHc3QldpaHN3bGx4VVRhaFo1cjJKUDNhQndtcjZ0?=
 =?utf-8?B?ekNSaVJuWEpKdkhIa0o0LzV2endlYndPZEhiTDRRUnFVcDdMNEZHNW5aS2dG?=
 =?utf-8?B?L3YwVHVYc0d1SGVtRUNGR1AvNzBaZzhJWHBucG1leDJpS3EzcG5sNG02dlIw?=
 =?utf-8?B?OUFIa2xZQWE3MnUrQUtPbVNaVjBOL3FCNGxsZEFWaUtZVEFEczZDcHpvV1pV?=
 =?utf-8?B?MTIrY3JUaEIyMXdqdmpLRTlPK0JnRVFjSmVoNzRkaTRTaVBHdVBVZWFYMjE2?=
 =?utf-8?B?enl2aWhVOHpJOVEzenJkL2lVM284UTl1Tzk2UlVmcDdUODJiSy90T3R6NnRl?=
 =?utf-8?B?ZWNWR2pHVE4xTHNSSENvYTREQnlSUndWVlIyamhQM09JQnhwN3hsOFFaUzN6?=
 =?utf-8?B?Zmt5QXhYY1NhNWhZVnduRjhYVURSdkNaTTNudUo3R0FRaG80UjYrMENYY1Fu?=
 =?utf-8?B?L3RQdkoySzFzR3pkVFNRQTVFeHdtUjJxN3FlV0dMcldPUXBqeU5zV1ZXNlIr?=
 =?utf-8?B?eW5WTE5hNzZHamhhYkkrWGFvY2JaOURZRUlOaUE4bUc5a0Fwdjd0N3B0bHZI?=
 =?utf-8?B?S3pIZGM1OUpTTmg5SVhaV29kZzMwVGxnbmd0L0dvZStaNUdJMnpsY3ZvL3NN?=
 =?utf-8?B?eFVQc0R4QjNIakNVdXNWbk95dWdUY1VQSlMzRUw3L25WWTZRbE41L1gzOEly?=
 =?utf-8?B?eS81UHI2aUlmV3RyR1ZXQUtEQ2l3SGdEcWI0eVNUa3owQi9EeG8vU2laYnhN?=
 =?utf-8?B?U1habEhpa2YvTUlqOFIyZkVRZE5yalErayszUURpVXUzdTNwZGdsMExBMGR3?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d9303a-0f58-4dc5-12c7-08dabd03f9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 18:56:40.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQVWyjOqjKUYt/NU2f/5lI9S6J+2c36mLSfjxCMx85LijR262ymT31erI5+Kt5l8JUZFwxsuKTS3YjHhm1ZIqQN4pCOAOmtFv9GdnKOk3hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMSwgMjAyMiAxMDozMSBBTQ0KPiANCj4gV2ls
bCBiZSB1c2VkIGxhdGVyIGtlZXAgdGhlIGFkZHJlc3Mgb2YgdGhlIHJlbWFwcGVkIHBhZ2UgZm9y
IHRoZSByb290DQo+IHBhcnRpdGlvbi4NCg0Kcy9sYXRlciBrZWVwL2xhdGVyIHRvIGtlZXAvDQoN
CkknZCBsaWtlIHRvIHNlZSBhIG1vcmUgcm9idXN0IGNvbW1pdCBtZXNzYWdlLCBhbmQgbm90IGEg
cGFydGlhbA0Kc2VudGVuY2UgdGhhdCBpcyBhIGNvbnRpbnVhdGlvbiBvZiB0aGUgY29tbWl0IHRp
dGxlLiAgU29tZXRoaW5nIGFsb25nIHRoZQ0KbGluZXMgb2Y6DQoNCldoZW4gTGludXggaXMgcnVu
bmluZyBpbiB0aGUgcm9vdCBwYXJ0aXRpb24gb2YgdGhlIE1pY3Jvc29mdCBIeXBlcnZpc29yLA0K
dGhlIG1lbW9yeSBmb3IgdGhlIFRTQyBwYWdlIGlzIHByb3ZpZGVkIGJ5IHRoZSBoeXBlcnZpc29y
LCBzbyB0aGUgVFNDDQpwYWdlIGFkZHJlc3MgY2FuJ3QgYmUgdGhlIGFkZHJlc3Mgb2YgYSBMaW51
eCBnbG9iYWwgdmFyaWFibGUuDQoNCkludHJvZHVjZSBhIGdsb2JhbCB2YXJpYWJsZSB0byBjb250
YWluIHRoZSBUU0MgcGFnZSBhZGRyZXNzLiAgRm9yIGEgZ3Vlc3QgVk0sDQppdCBkZWZhdWx0cyB0
byB0aGUgYWRkcmVzcyBvZiB0aGUgTGludXggZ2xvYmFsIHZhcmlhYmxlLiAgSWYgcnVubmluZyBp
biB0aGUgcm9vdA0KcGFydGl0aW9uLCBhIGxhdGVyIHBhdGNoIG92ZXJyaWRlcyB0byBiZSB0aGUg
YWRkcmVzcyBvZiB0aGUgcGFnZSBwcm92aWRlZCBieQ0KdGhlIGh5cGVydmlzb3IuDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpeSA8c3RhbmlzbGF2LmtpbnNidXJz
a2l5QGdtYWlsLmNvbT4NCj4gQ0M6ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5j
b20+DQo+IENDOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiBDQzog
V2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiBDQzogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT4NCj4gQ0M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnPg0KPiBDQzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYyB8ICAg
IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVy
LmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+IGluZGV4IDExMzMyYzgy
ZDFhZi4uYzRkYmY0MGEzZDNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5
cGVydl90aW1lci5jDQo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMN
Cj4gQEAgLTM2Niw5ICszNjYsMTEgQEAgc3RhdGljIHVuaW9uIHsNCj4gIAl1OCByZXNlcnZlZFtQ
QUdFX1NJWkVdOw0KPiAgfSB0c2NfcGcgX19hbGlnbmVkKFBBR0VfU0laRSk7DQo+IA0KPiArc3Rh
dGljIHN0cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKnRzY19wYWdlID0gJnRzY19wZy5wYWdlOw0K
PiArDQo+ICBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkN
Cj4gIHsNCj4gLQlyZXR1cm4gJnRzY19wZy5wYWdlOw0KPiArCXJldHVybiB0c2NfcGFnZTsNCj4g
IH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGh2X2dldF90c2NfcGFnZSk7DQo+IA0KPiBAQCAtNDA2
LDcgKzQwOCw3IEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfaHZfY2xvY2tfdHNjKHN0cnVjdCBjbG9j
a3NvdXJjZSAqYXJnKQ0KPiANCj4gIHN0YXRpYyB2b2lkIHJlc3VtZV9odl9jbG9ja190c2Moc3Ry
dWN0IGNsb2Nrc291cmNlICphcmcpDQo+ICB7DQo+IC0JcGh5c19hZGRyX3QgcGh5c19hZGRyID0g
dmlydF90b19waHlzKCZ0c2NfcGcpOw0KPiArCXBoeXNfYWRkcl90IHBoeXNfYWRkciA9IHZpcnRf
dG9fcGh5cyh0c2NfcGFnZSk7DQo+ICAJdW5pb24gaHZfcmVmZXJlbmNlX3RzY19tc3IgdHNjX21z
cjsNCj4gDQo+ICAJLyogUmUtZW5hYmxlIHRoZSBUU0MgcGFnZSAqLw0KPiANCg0K
