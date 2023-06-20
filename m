Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D637368DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFTKJU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTKJT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 06:09:19 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020023.outbound.protection.outlook.com [52.101.128.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167F8A3;
        Tue, 20 Jun 2023 03:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMqcq/JjKBStrnOeeBua77gSRXSQoUJNLbczbhjMVOhVJ4edmHg3px4StEedO9L26DvBDNxY6/Vrlz15FslQUgpetyQ5J18KNiJjTztapJq1LYrrunWk4jF4MAEpUaqH9L08Uf1+k53Ix/VlGXuEoRpdKWg03gWQFZ6e6R2XI6Qwyc52p134AQx403bbOwf7Wq5nTikZRrXRM/o6wQ3ByreBn3eQiGuhArEWiayfM40rQ5zax1tz3KEmmdV05DfbIj3Ks2TvgSt69Igm+dxESgoy4i18nyo77kznOVMnwU1j51Z4w7TcQNj4RyAJGNZwKH2QXWH09ntFVHIcVut4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xImgZdiXjrJHPHD5wGN67CkmyESLLhbbuacNTOhcaVk=;
 b=Ki3Sx/e+z1ncvnNdD6mm14W5Ci7PwfP5chXm4OEUSpEUTH5JMI++Mq7AJBhlq8B1OUkXY31mTRisUf8eNmBYECfZNQ1inLkLllAd7cKOX2KrVNlmhm3sfTVki6OIeI1yqPu4ll9Z1/lEMrzCjvSqRV/Gqn237OvKjsWfODURatrh/E368y7LxUmh7Kmf6776j3rPi4q8PMPSBaOIJAD8cqYhTPQEC6Zze6+/6INR8Tsi7YVE+WuLVJKJwCiJtOTywhleXxJBPcp83wNMxSbwUvK/yut5xPVJZhaRSUt+DfdZDO4iy47lJ5Zy7xOA2qiJlZ2ig1JIfK5eibQr4NuZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xImgZdiXjrJHPHD5wGN67CkmyESLLhbbuacNTOhcaVk=;
 b=KR7jU0bQiLzsq7sCM6ZxaWeEJ7pJifFwzQYRo6P5F4T0NxF+amdEbnwgngwLEf0xWjYthIeOW7ZmI9nmW9TkC7TWeI+KkrdoMaOXAqtQmj68h/RjlUGNhHxtnWaCuktm6LiZHA9LpTuJnTDkxpm+VzTCoVv29BK0PugG0oQLVfk=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 KL1P15301MB0420.APCP153.PROD.OUTLOOK.COM (2603:1096:820:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.6; Tue, 20 Jun
 2023 10:09:12 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6521.013; Tue, 20 Jun 2023
 10:09:12 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Topic: [EXTERNAL] Re: [PATCH v2] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Index: AQHZnh0lKnuNcu7zBUaRJymNhkyK/q+JpXTQgAnb9TA=
Date:   Tue, 20 Jun 2023 10:09:11 +0000
Message-ID: <PUZP153MB074981D5C1823DFF47166668BE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1686640391-13001-1-git-send-email-ssengar@linux.microsoft.com>
 <23749756-022a-5574-af4d-a4a03d9542e1@intel.com>
 <SEZP153MB0742622EE41C33148CB598DDBE5AA@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SEZP153MB0742622EE41C33148CB598DDBE5AA@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b3a03ef5-16ad-4ad8-8abb-693a4603898d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-14T03:32:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|KL1P15301MB0420:EE_
x-ms-office365-filtering-correlation-id: 96d4c67a-4b59-48c8-aa3d-08db71766524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vjub2xh1kaKfH5KAs+fD8XMqOC5NGxLo63ub60E5trEMf2Ag5MuniDsx3Uo4hnbaOq/L+mp41xo0lrit4RbzrfyYc3qn5RLXmFWz4z4YrSGe0Te2gO60vAQ+DdklGUZbCIVAGb6Q9dfkTTPkVLnE2uBmVHsKloLLgF2t+xkoPAVTy+2lirs7n7okGCwkm5ex0qJhQafz0RoonWQ3FuPLaDChoyuQH44eHGXnBRlnV0J7YvGiTzRo/9szUEBclKB/D1wLXe+PWKymLbNOtNdo6jMoMaSfYbsSF1CaQzVyC08d9GcizdKiSB3DySuzThCdqBSRn3TowhxLkMLgrqHuQvbuT2qO7H2Dgl1C2VXV1VcTy83BQzo7undvxM8Ln6j6t8En5vI6BBQWnNJbXlXj5WXZYahTt7v3pVMUHA6jmURETYxdbHzy6Qxk/rGzE3qJEQaESJl8v93P6/2q5t1v5ntqnDqRqRuLw3Yay2S/YJK8DXFwUO9hbhlziSGUMqgK1U4+//EuIXTbna/nzpz/FG/Ie2df2V1GRsOwDINHNDN+Rr8zwbgkL2uESR/of3fGyG45EAL6Y5UUwD/5UXPXizaz05Vrkw0O++SUyopIyvLAY8u0xQohikNzACmbbt7OECL5nADg3GkWg8Jsk6XbjLyLexZ/a/lR6+nM7HR/7+NvoT3963lp0s34jjzJ6cEz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(71200400001)(7696005)(478600001)(10290500003)(33656002)(186003)(9686003)(53546011)(83380400001)(38070700005)(86362001)(38100700002)(921005)(122000001)(6506007)(82960400001)(82950400001)(55016003)(66556008)(64756008)(66446008)(66946007)(76116006)(66476007)(316002)(8936002)(8676002)(52536014)(5660300002)(7416002)(41300700001)(2906002)(110136005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek94em1LVEhpZ0lHdFRXRjc1d1AxUURBTE1iempHeE4xY053bjE4ZVl0dHlC?=
 =?utf-8?B?Q2FCa0RoNlpJcWxWVWtGVk8zMEttenZOcHMwQ2tPdENpRk95N1k5a0tVeVQ2?=
 =?utf-8?B?bUtqZUNzanpoTjk1eUxNN3RyWVpJdDZEWGtIRDVXYkRpRHkraUgxRG5rV2E2?=
 =?utf-8?B?SU02UkFCZURxTGljMWY1MHNhbG1Kc0hlMWYwZ1JNV2FlTkJIQ2VEZGNJU3BY?=
 =?utf-8?B?WnVKTTh1TXpTczB4cElhRWFpVWdja05lK0t5SndReGlEbEltVHNtTk1OZUhO?=
 =?utf-8?B?SGsxc3EzYytIanlpL3RTamIveXF2UjZGejVwakFja2hQMkVoQWNaUCtPVXFl?=
 =?utf-8?B?a0JLU01mRU9FaUNqTmRDV0ROekFwUWc3YWF2VC8yRmpjdTRPMk1waTQ5djZn?=
 =?utf-8?B?OWRySlAvRmk5alllU0UvRjlGMzR4NndkUE1ZbS8vYUZrN05kMFJiRVRwamZQ?=
 =?utf-8?B?eVlBcEppa2VzekVYOGFzUkoxT2djdDQ4WWtWL0Z2SWhTSHRuZjNWYTdyeGs3?=
 =?utf-8?B?S2lGVU1iR2gxYk8zRTRWZFVnTXZxNHNvU0NpdGZMQ1RLWEtxaXd4UE9tWEY5?=
 =?utf-8?B?UHNYeU5EeGYxU0tyL2tUVkI3ZnV1d01WbzFsaDhiVGpMTlBteFgyeTFZRmh5?=
 =?utf-8?B?a21aYzFxOFFKRWw2QVpoRTVPVHFZVTJlR1BZWWttNDZzSndtK2IrOEpuVkNx?=
 =?utf-8?B?ZlJmLzlGSy9MR3NacHB4QkJ5c0pXWExSUndiSnozTE9TWERkTUxlbWRMelAv?=
 =?utf-8?B?T2FqRSt1QW1Ba09LWmR3bm4zWmExVzgrUi9veWpkb3BNc0pZcnJGcjcyY1ph?=
 =?utf-8?B?YVlxeEdZOGZxNFdnbnBYWmF2QkxBRmpCUS85bktWdWhnRS9tK3ZKV3h1QXBI?=
 =?utf-8?B?dWhOdlRUdk9vdXZYM2lUdGFINWhGNkN6eVM1akJDakVNWEx2S1hnSzFmQUFM?=
 =?utf-8?B?SW4ySjRDSXh4RG5aSVFzK1BQcjlWMEppc2N6Z0xLeG1jWTVoQjZjZHJJcWIr?=
 =?utf-8?B?UE5MWDExUUgxZWRGOXJFTWszT1Nka1hWMS9aN3RDNThVcno3RTV0MlZEdzdW?=
 =?utf-8?B?TWRDQXMwWWR0cUw0V29RV1FuZ0hOWUtJT3JvdXJINWMxSHgrQkJ1UGxja25V?=
 =?utf-8?B?YldPZkZrTTkzRnk1cHRjRXpET0txRS9nUDRhZmQwQ0hWL3BhV0EySzU2TFF1?=
 =?utf-8?B?aTd1d0xOYm1DQ2RSaUNCV2RpYjZVblIzc2RqcVdUT0dqd0htR1IzK25ZL0M5?=
 =?utf-8?B?L0c1YUFyRTIzYVUraXF4aVYxQU1USUp0cDVZSkdjazAxOHVNancwY1M0ZWhw?=
 =?utf-8?B?c0R3VkhodHViM0lUNFlmTWJyMWNPRkxHVmlXeHh3SzNkMTlEZ1VVRFdVWDNN?=
 =?utf-8?B?MzdYYVdsVC9WUVBRbTJTbHJ3UkF3TzU0NlkxbkFyVkhCQTZJMW1aU2lLWnFm?=
 =?utf-8?B?bnBXcTBnV0xBL2pDeEtiUW95SHgrdjFMU3lxcDdiT1NIK1VkSkxGZE1VUVVP?=
 =?utf-8?B?NXAvNTZGNmExaXdDa0FweHVuRTVaV2N3bktmU0d1RHQxL1FLOElNQWRJVllo?=
 =?utf-8?B?Q0cyZTNDc1NXcFV2eUNBYXg0d3hNRko1SUx0c2cyTjRRaXVhRlYyU3MrTnYz?=
 =?utf-8?B?YlhPWUdoczFoREEzNnN3dVQvaXJXNFl0MzJIbDZLSTlZUEJyckVkSklTMnQ1?=
 =?utf-8?B?YUZTTlhxSlQxMDFXdFhRdFRFVTFyN1JWdFZHaFlaWmdJQWJOQzhhdkNIcWlU?=
 =?utf-8?B?NVY3SnRIZS9LNUVOSWsrcTEyT2VjdUZkeGF1bVhhdDNtNXd6enlHcngxbTB0?=
 =?utf-8?B?dVBMNkVFWXpxZHdFM3lPcmZIeWI5SFp5LytTYTRKNjJxMW9qaFhUaTkxWitm?=
 =?utf-8?B?UVAvK09qbG8yM2dJVGRSWUp1MHVGL1hHSHpZMWVpUkYwdWZiaWJ6RndqOWJQ?=
 =?utf-8?B?aG9Od0hoWVRMakNVKytsMk1HMWNQQ1FHTXlNejZoczEzSjYrbGcwZURlRXUy?=
 =?utf-8?B?MmVCV1JJN3ArTHpWQUpJM1B5eVl1bDZWMm5QY2xEbHczUnJWcmwvQUQ1bDQx?=
 =?utf-8?B?Z3RDRXlaNkI5dGNOanlNNWtWOG5WUlErbXU5TjM5NlNhL3htcUI5SkhkT3cw?=
 =?utf-8?Q?d8n3eHozbMQ9KOUqrkFiAHHS+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d4c67a-4b59-48c8-aa3d-08db71766524
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 10:09:12.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcPJCEWadPlaXjRukefLKRIDvMepY9Z2EneSYHVmf9GE/AmZXN1alFxYoVcAP52ib4iBRBp07YonqiPun/mASQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2F1cmFiaCBTaW5naCBT
ZW5nYXIgPHNzZW5nYXJAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE0
LCAyMDIzIDk6MzYgQU0NCj4gVG86IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+
OyBTYXVyYWJoIFNlbmdhcg0KPiA8c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tPjsgS1kgU3Jp
bml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+Ow0KPiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPjsgd2VpLmxpdUBrZXJuZWwub3JnOyBEZXh1YW4gQ3VpDQo+IDxkZWN1aUBt
aWNyb3NvZnQuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBi
cEBhbGllbjguZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7
IE1pY2hhZWwgS2VsbGV5DQo+IChMSU5VWCkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9y
ZzsgaHBhQHp5dG9yLmNvbQ0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBSZTogW1BBVENIIHYy
XSB4ODYvaHlwZXJ2OiBhZGQgbm9vcCBmdW5jdGlvbnMgdG8NCj4geDg2X2luaXQgbXBwYXJzZSBm
dW5jdGlvbnMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+ID4gU2VudDogVHVl
c2RheSwgSnVuZSAxMywgMjAyMyAxMTowMyBQTQ0KPiA+IFRvOiBTYXVyYWJoIFNlbmdhciA8c3Nl
bmdhckBsaW51eC5taWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2YXNhbg0KPiA+IDxreXNAbWljcm9z
b2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+Ow0KPiA+IHdl
aS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47DQo+ID4g
dGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7DQo+ID4g
ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgTWljaGFlbCBLZWxs
ZXkgKExJTlVYKQ0KPiA+IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPjsgbGludXgtIGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgaHBhQHp5
dG9yLmNvbQ0KPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2Ml0geDg2L2h5cGVy
djogYWRkIG5vb3AgZnVuY3Rpb25zIHRvDQo+ID4geDg2X2luaXQgbXBwYXJzZSBmdW5jdGlvbnMN
Cj4gPg0KPiA+IE9uIDYvMTMvMjMgMDA6MTMsIFNhdXJhYmggU2VuZ2FyIHdyb3RlOg0KPiA+ID4g
SW4gY2VydGFpbiBjb25maWd1cmF0aW9ucywgVlRMMCBhbmQgVlRMMiBjYW4gc2hhcmUgdGhlIHNh
bWUgVk0NCj4gPiA+IHBhcnRpdGlvbiBhbmQgaGVuY2Ugc2hhcmUgdGhlIHNhbWUgbWVtb3J5IGFk
ZHJlc3Mgc3BhY2UuIEluIHN1Y2gNCj4gPiA+IHN5c3RlbXMgVlRMMiBoYXMgdmlzaWJpbGl0eSBv
ZiBhbGwgb2YgdGhlIFZUTDAgbWVtb3J5IHNwYWNlLg0KPiA+DQo+ID4gRldJVywgdGhpcyBpcyBw
cmV0dHkgbXVjaCBnaWJiZXJpc2ggdG8gbWUuICBUaGUgd2F5IEkgc3VnZ2VzdCBhdm9pZGluZw0K
PiA+IHByb2R1Y2luZyBnaWJiZXJpc2ggaXMgYXZvaWRpbmcgYWNyb255bXM6DQo+ID4NCj4gPiAJ
SHlwZXItViBjYW4gcnVuIFZNcyBhdCBkaWZmZXJlbnQgcHJpdmlsZWdlICJsZXZlbHMiLiAgU29t
ZXRpbWVzLA0KPiA+IAlpdCBjaG9vc2VzIHRvIHJ1biB0d28gZGlmZmVyZW50IFZNcyBhdCBkaWZm
ZXJlbnQgbGV2ZWxzIGJ1dA0KPiA+IAl0aGV5IHNoYXJlIHNvbWUgb2YgdGhlaXIgYWRkcmVzcyBz
cGFjZS4gIFRoaXMgPGluc2VydCByZWFzb24NCj4gPiAJdGhhdCBzb21lb25lIG1pZ2h0IHdhbnQg
dG8gZG8gdGhpcz4uDQo+ID4NCj4gPiBUaGF0J3Mgbm90IGdpYmJlcmlzaC4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBzdWdnZXN0aW9uIEkgY2FuIGFkZCB0aGlzIGluIHYzLg0KPiANCj4gPg0KPiA+
ID4gV2hlbiBDT05GSUdfWDg2X01QUEFSU0UgaXMgZW5hYmxlZCBmb3IgVlRMMiwgdGhlIGtlcm5l
bCBwZXJmb3JtcyBhDQo+ID4gPiBzY2FuIG9mIGxvdyBtZW1vcnkgdG8gc2VhcmNoIGZvciBNUCB0
YWJsZXMuIEhvd2V2ZXIsIGluIHN5c3RlbXMNCj4gPiA+IHdoZXJlDQo+ID4gPiBWVEwwIGNvbnRy
b2xzIHRoZSBsb3cgbWVtb3J5IGFuZCBtYXkgY29udGFpbiB2YWxpZCB0YWJsZXMgc3BlY2lmaWMN
Cj4gPiA+IHRvIFZUTDAsIHRoaXMgc2Nhbm5pbmcgcHJvY2VzcyBjYW4gbGVhZCB0byBjb25mdXNp
b24gd2l0aGluIHRoZSBWVEwyDQo+ID4gPiBrZXJuZWwuDQo+ID4NCj4gPiBXaGF0IGlzIHRoZSBl
bmQtdXNlci12aXNpYmxlIGVmZmVjdCBvZiB0aGlzICJjb25mdXNpb24iPyAgQSBjcmFzaD8gIEEN
Cj4gd2FybmluZz8NCj4gPiBBbiBlcnJvciBtZXNzYWdlPyAgV2hhdCBpcyB0aGUgaW1wYWN0IG9u
IGVuZCB1c2Vycz8NCj4gDQo+IFRoZSBWVEwyIGtlcm5lbCBpcyBjdXJyZW50bHkgc2Nhbm5pbmcg
dGhlIFZUTDAgTVAgdGFibGUgYW5kIGluY29ycG9yYXRpbmcNCj4gdGhhdCBpbmZvcm1hdGlvbiwg
d2hpY2ggaXMgaW5jb3JyZWN0IGJlY2F1c2UgVlRMMiBkb2Vzbid0IHN1cHBvcnQgTVAgdGFibGVz
DQo+IGFuZCBpbnN0ZWFkLCBpcyBib290ZWQgd2l0aCBEVC4gV2hpbGUgSSBkb24ndCBoYXZlIGFu
IGltbWVkaWF0ZSBjcmFzaCBvcg0KPiBlcnJvciBtZXNzYWdlIHRvIHByZXNlbnQsIHRoaXMgc2l0
dWF0aW9uIGNvdWxkIHBvdGVudGlhbGx5IHJlc3VsdCBpbiBpbmNvcnJlY3QNCj4gYmVoYXZpb3Vy
Lg0KPiANCj4gPg0KPiA+IFRoaXMgaW5mb3JtYXRpb24gd2lsbCBoZWxwIHRoZSBtYWludGFpbmVy
cyBkZWNpZGUgaG93IHRvIGRpc3Bvc2l0aW9uDQo+ID4geW91ciBwYXRjaC4gIFNob3VsZCB3ZSBz
ZW5kIGl0IHVwc3RyZWFtIGltbWVkaWF0ZWx5IGJlY2F1c2UgaXQncw0KPiA+IGltcGFjdGluZyBt
aWxsaW9ucyBvZiB1c2Vycz8gIE9yIGNhbiB3ZSBkbyBpdCBpbiBhIGJpdCBtb3JlIGxlaXN1cmVs
eQ0KPiA+IGZhc2hpb24gYmVjYXVzZSBub2JvZHkgY2FyZXM/DQo+IA0KPiBJIHVuZGVyc3RhbmQs
IEkgaGF2ZSBwcm92aWRlZCBhbGwgdGhlIGluZm9ybWF0aW9uIEkgaGF2ZSBwbGVhc2UgY29uc2lk
ZXIgd2hhdA0KPiBpcyBhcHByb3ByaWF0ZSBpbiB0aGlzIGNhc2UuDQo+IA0KPiA+DQo+ID4gPiBJ
biAhQUNQSSBzeXN0ZW0sIHRoZXJlIGlzIG5vIHdheSB0byBkaXNhYmxlIENPTkZJR19YODZfTVBQ
QVJTRSBoZW5jZQ0KPiA+ID4gYWRkIHRoZSBub29wIGZ1bmN0aW9uIGluc3RlYWQuDQo+ID4NCj4g
PiBUaGlzIG1ha2VzIHplcm8gc2Vuc2UgdG8gbWUuDQo+IA0KPiBNeSBpbnRlbnRpb24gd2FzIHRv
IHRlbGwgdGhhdCB0aGlzIGZpeCBpcyByZXF1aXJlZCBiZWNhdXNlIHdlIGFyZSBpbiAhQUNQSQ0K
PiBzeXN0ZW0uDQo+IElmIGl0IHdhcyBBQ1BJIHN5c3RlbSB3ZSBjb3VsZCBoYXZlIHNpbXBseSBk
aXNhYmxlIHRoaXMNCj4gQ09ORklHX1g4Nl9NUFBBUlNFIE9wdGlvbi4gQnV0IGFzIHlvdSBzdWdn
ZXN0ZWQgSSBhbSBmaW5lIHJlbW92aW5nDQo+IHRoZXNlIDIgbGluZXMuDQo+IA0KPiA+DQo+ID4g
TGlrZSBJIHRvbGQgeW91IGJlZm9yZSwgd2UgZG9uJ3QgY29tcGlsZSB0aGluZ3Mgb3V0IGp1c3Qg
YmVjYXVzZSB0aGV5DQo+ID4gZG9uJ3Qgd29yayBvbiBvbmUgd2VpcmRvIHN5c3RlbS4gIElmIHdl
IGRpZCB0aGF0LCB3ZSdkIGhhdmUgYSBiaWxsaW9uDQo+ID4gaW5jb21wYXRpYmxlDQo+ID4geDg2
IGtlcm5lbCBpbWFnZXMgdGhhdCBjYW4ndCBib290IGFjcm9zcyBzeXN0ZW1zLg0KPiA+DQo+IA0K
PiBVbmRlcnN0b29kLCB0aGFuayB5b3UuIEkgd2FzIGp1c3QgY29uc2lkZXJpbmcgdGhlIG9wdGlv
biBvZiBrZWVwaW5nIHRoZQ0KPiBkZWZhdWx0IHNldHRpbmcgZm9yIENPTkZJR19YODZfTVBQQVJT
RSBhcyAnWScgYW5kIGFsbG93aW5nIHRoZSBjaG9pY2UgdG8NCj4gY2hhbmdlIGl0IHRvICdOJyBp
ZiBzb21lb25lIHNwZWNpZmljYWxseSBkZXNpcmVzIHRvIGRvIHNvLiBJIGFsc28gY29uc2lkZXJl
ZCB0aGF0DQo+IG5vd2FkYXlzLCBub3QgbWFueSBrZXJuZWxzIGFyZSBsaWtlbHkgdG8gdXRpbGl6
ZSBNUCB0YWJsZXMgZm9yIGJvb3RpbmcgeDg2DQo+IG1hY2hpbmVzLCB3aGljaCBpcyB3aHkgSSB0
aG91Z2h0IHRoaXMgY2hhbmdlIHdvdWxkbid0IGhhdmUgYSBzaWduaWZpY2FudA0KPiBpbXBhY3Qu
IE1vcmVvdmVyLCB0aGVyZSBpcyBhIHBvdGVudGlhbCBiZW5lZml0IGluIHRlcm1zIG9mIHJlZHVj
aW5nIHRoZQ0KPiBrZXJuZWwncyBzaXplLiBIb3dldmVyLCBJIGNvbXBsZXRlbHkgcmVzcGVjdCBh
bmQgYW0gb3BlbiB0byB3aGF0ZXZlciB5b3UNCj4gZGVjaWRlLCBoYXZpbmcgYmV0dGVyIHZpc2li
aWxpdHkgb2Ygd2lkZXIga2VybmVsIGNvbW11bml0eSBuZWVkcy4NCj4gDQo+IC0gU2F1cmFiaA0K
DQpCZWxvdyBpcyB0aGUgdXBkYXRlZCBjb21taXQgbWVzc2FnZSwgaWYgdGhlcmUgYXJlIG5vIG1v
cmUgY29uY2VybnMgSSB3aWxsDQpzZW5kIHRoZSBWMyB3aXRoIGl0Lg0KDQpIeXBlci1WIGNhbiBy
dW4gVk1zIGF0IGRpZmZlcmVudCBwcml2aWxlZ2UgImxldmVscyIga25vd24gYXMgVmlydHVhbA0K
VHJ1c3QgTGV2ZWxzIChWVEwpLiBTb21ldGltZXMsIGl0IGNob29zZXMgdG8gcnVuIHR3byBkaWZm
ZXJlbnQgVk1zDQphdCBkaWZmZXJlbnQgbGV2ZWxzIGJ1dCB0aGV5IHNoYXJlIHNvbWUgb2YgdGhl
aXIgYWRkcmVzcyBzcGFjZS4gSW4NCnN1Y2ggc2V0dXBzIFZUTDIgKGhpZ2hlciBsZXZlbCBWTSkg
aGFzIHZpc2liaWxpdHkgb2YgYWxsIG9mIHRoZQ0KVlRMMCAobGV2ZWwgMCkgbWVtb3J5IHNwYWNl
Lg0KDQpXaGVuIHRoZSBDT05GSUdfWDg2X01QUEFSU0UgaXMgZW5hYmxlZCBmb3IgVlRMMiwgdGhl
IFZUTDIga2VybmVsDQpwZXJmb3JtcyBhIHNlYXJjaCB3aXRoaW4gdGhlIGxvdyBtZW1vcnkgdG8g
bG9jYXRlIE1QIHRhYmxlcy4gSG93ZXZlciwNCmluIHN5c3RlbXMgd2hlcmUgVlRMMCBtYW5hZ2Vz
IHRoZSBsb3cgbWVtb3J5IGFuZCBtYXkgY29udGFpbiB2YWxpZA0KdGFibGVzLCB0aGlzIHNjYW5u
aW5nIGNhbiByZXN1bHQgaW4gaW5jb3JyZWN0IE1QIHRhYmxlIGluZm9ybWF0aW9uDQpiZWluZyBw
cm92aWRlZCB0byB0aGUgVlRMMiBrZXJuZWwsIG1pc3Rha2VubHkgY29uc2lkZXJpbmcgVlRMMCdz
IE1QDQp0YWJsZSBhcyBpdHMgb3duDQoNCkFkZCBub29wIGZ1bmN0aW9ucyB0byBhdm9pZCBNUCBw
YXJzZSBzY2FuIGJ5IFZUTDIuDQoNCi0gU2F1cmFiaA0K
