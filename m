Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D99720784
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjFBQZt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjFBQZn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 12:25:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC52E67;
        Fri,  2 Jun 2023 09:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRgiyi7QOOIZ0m5yWOLgVdoSYdlsT71umr3o0FVRWvM9V2cR3wB217qBdTr1BosdlSsro62nUixYx7YGHOWjepR1b4JYO6+yAIuyt/wabLKolUk9mfAOXRACgjoHn8YSoHoVAEmxx1W6YyEnZ1AyiSc9niMIr+WNzMXi4LcaX26vwNkYN4hIb+EAE5wb2MU0c0LKQqmZP1wGWKOMzcnTHgDrL2I33ou2wVImQMYRLNu0dWpaJKpXX+NmYwW+O2jSYrfrGwpBczKag7kAkctKr3nyuFWS5GUE63F+GrPtLxUcJAfjUk7SV/ixxP5RQKyt9T9nDzStZMO4PolDMP6Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj+5PAR+LXAG+dj2zJPMQa8URe5jnS/4HhF4rI3KoC4=;
 b=DpDhusCFg94hEh80MuDXw6f/dK2NDkK5jxi+qJJf+WeTbQU41v86XpYyruNoEH2K50c17W4r1yBUjDn4JkyFro+8QXSScf/l2RSyuRRuFPIyT6mIgIlhzlAGx6ZBho+0a7ZVYv3O1KEF0wkfKrtFF/9PyWLrdEdpSEz0gdEAzq19duYB+t4M4okk4jFYZ6rAIC6YAGs+vnygYrf+JbZvdTbhlxCrp1ghqEy5YqGoGaBuRaYthFXfuS0azXa7EwG/cCXAXP/vB0lqphvL+ZLUyTTY3Mi2ooFCpA4T3mqiLDazVe0NVjygyUe9P6cGZxyn66gZS3nDaEcE3YQznz9a3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj+5PAR+LXAG+dj2zJPMQa8URe5jnS/4HhF4rI3KoC4=;
 b=gbIutUd5oqDm7jn1LTCWUKADcCp2dQUbWyzzejfF6/PbKp+w5BaYhJOD4OFnf61dDgFlO0SMXSjAH9Dbu+C3yGmKXyVzUhnzy25xrHkNGhhKMVx8q2vWKDOE5fTjToxbj4L3FHwQF8BELimriIdR0BgoSGSjWS871ISkwSDIov8=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SI2P153MB0703.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.12; Fri, 2 Jun 2023 16:25:35 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6477.012; Fri, 2 Jun 2023
 16:25:35 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Index: AQHZhBiUq424crV8z0Sj0fJkb54l069oNpQAgAF1oECAAB95AIAAz9nAgAB9mgCADHVq8IAAJOGAgAAcp0A=
Date:   Fri, 2 Jun 2023 16:25:34 +0000
Message-ID: <PUZP153MB07495D304C4A026CC72C3335BE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
 <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
 <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <13922610-b9bc-ab4b-8482-9aae238396c7@intel.com>
 <PUZP153MB07490EDED3B0194F5518B26EBE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <e5ca0f92-0909-68af-16e0-582f47d8e424@intel.com>
In-Reply-To: <e5ca0f92-0909-68af-16e0-582f47d8e424@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f81edd7c-f71d-4d56-b65a-033d4fc117bd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-02T16:06:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SI2P153MB0703:EE_
x-ms-office365-filtering-correlation-id: d8a492c7-bd12-425b-7619-08db6385fe29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjfKPhGOV/RcAa7d0jMwGmNOCjD0zC6Nzea88PqjO0FACCnrvSpUpjUHocGHzCItgjkxmkcvh++1U0fjio8wnSHmICo5LDycK5ALvfi2pJBtFj2gzH+NDjPAamfLFQME6yCU57udHWTT8kzhZHpgwFe7OvrKIMGX9gt01sxda/r7l058ClIwZbd/ebF2nrK9A45lwtjh5VP4LLgWlMfSI2FFAcvrVnD15jfnyWV2TewiOE+zj0eA8wE2eKH+O2QQuWFPxu37SNGN5YK1CWInwj+xE51433p1pF1ySjQ50W0JG6LTPU7M7ygdm7mJKl6dQcF5GxVppHdG2Ngxu+47x1wS9MK93IeAXFMCB36xIL1VdmvxxV/ELSCf6+3Ul47aFB5cmh5sR68+qiUyk5RXrisiqEI9GVtPJH2dCHGdi0ck1zYqRWpUTxmeJLgUcPWs4T0d2WRw+t/MqD6M5p4UIvkn4QKHd0j4vxECzUFjYqNZUWTs/KQ1REdIjPjs40yLI4kMVOZLkh1vpJ5OLSK5fBb7z++0ZyM0EG55aB7qiGlwo/bV9gNJnZUslC1vwTIlP3UKDlAo+C3DnV5Fz7HoKqpz1ohgHp7N4YTPqYO8xkFr3+U2FSv0X3YND3+PBeppQYm6iYaCLJIKhRuP5kLw7shbljQ16bRwS4IUQNtSEzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(33656002)(478600001)(10290500003)(9686003)(186003)(53546011)(6506007)(7696005)(55016003)(83380400001)(71200400001)(966005)(41300700001)(38100700002)(64756008)(921005)(82950400001)(82960400001)(122000001)(66446008)(66556008)(66476007)(66946007)(316002)(786003)(7416002)(86362001)(2906002)(52536014)(5660300002)(38070700005)(76116006)(8936002)(8676002)(110136005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHdsZzNXdWFtSEVNaXE5ME1EWHNQODI4YW9QNnIzaXZQSndCaXZxMEszclRj?=
 =?utf-8?B?MGVSU05oOStBeFA3anRuM0R0Zm44MHdVZkM4Z2JzT2NvblJNOWRISWcyZTF6?=
 =?utf-8?B?dXdOeHBKT1FLS2NuM2RVaTlwcnZ5YzBHZXJ6QWg0NnV4VUNCWlAyNE9id3My?=
 =?utf-8?B?L3BzcnlneHc5T1BpZ0cvekJGUzY0T0tzTXRCVCswUlJxZjJ3eHNFeERyS0U2?=
 =?utf-8?B?THN0MFVxSVA2NlhrZkVCdzYrTWFXMTlnQ1I5SWszaFptRlJxL205YVpSYUxj?=
 =?utf-8?B?eUQzQkJYakpwcWxsRVBvOWdnQWd4NlNEeWhvZ0JQTEZNZllmdnozaldDOStq?=
 =?utf-8?B?KzJvMEFBSGdqN3Zyd1dBc2k1K1BJbXRXRHFwRW5wSGQzbTlhQTNFZ0JRSHlR?=
 =?utf-8?B?blNaQ0p5bWpMdXpRa0NxNWhqbmpqQzk2dUQ0THQ0UE9yZ0VnblI3b2JSanda?=
 =?utf-8?B?dXRQQWlXNk10Z0RRUjlLV25FajJFc0lSQS9JeVdsS2h2a2crOWN6cFZjeGxM?=
 =?utf-8?B?NkxFNVlqa3k1eWJzWHFieTJ2NlgzNXk5cmtzUjJOcVQyYlcvVHJGVGpWQm5n?=
 =?utf-8?B?VHdXbGVzUnBWWFdsSks0aDNqRmtOY1dsOWZreGo2cUpWMXMxaG5mdWNyKzZM?=
 =?utf-8?B?cTJlT3I4d1Z3Ym13WEZPazF2aXZKb3JoU3RHcy9Uc0dscVA4eVZYdlRUbm5C?=
 =?utf-8?B?TWVSb0tWTmpwcW4rTHlmNjg2MFNZdDh6d0ovSjZXcTNTREwrWElPRkIvOUVu?=
 =?utf-8?B?MGhyamRqOHdtaWdvcUtNSGh6MVY5MWhnMUJBRDltK253SHpIdUxuU2w0R1VF?=
 =?utf-8?B?Q1RDTkNjVEk5eEVJZEp2dW9LTGVtU0xlZTY3bkYrMXVvZkNMZHdUQXhYQXJw?=
 =?utf-8?B?ekYxRmFrWDdqNmZqL2VrVXFHYVlzdnppM3hzMURoTmxpUjdZQnE1V0FRQ202?=
 =?utf-8?B?eURvcWxrdkhHRHVhaWhtcU8xRnVBb05DaGYyS2VTZi9kRXVlaklCS2lvRGQ3?=
 =?utf-8?B?VEJodWdRNTFFTTV2L3BNbXFUTW9PYVNDTU9sSzQ1WmEwNHhNSHRIdi9FamhP?=
 =?utf-8?B?dDA2dkdVTVUyOWdlZjFOZU94QTE5eThRb2xyQ2N0em5RTDZIV3B5U1JCZVd4?=
 =?utf-8?B?Vmw5d3NyUlFNRk42b1BrSnBTZ0FXNFpXVDFZejNxK2k0M1F5UHNoSCtVbndH?=
 =?utf-8?B?Vmh0NUlTcDlMZXp1Yi81bmVuVlFraDE4aVpOZTEwbXMrbzRUYlByM1M1QnhT?=
 =?utf-8?B?MlNaK3UxNUJlc2VwVThsRVBHTEVPZWF1SlpONVlrK1d5cUNlWDRPOG9lK1B6?=
 =?utf-8?B?SU5pcDhvNC9yQ1p0RjF0alZQOXMvTEk0LzhNNGplZ3ZQRWRXeUFzMUVZNFZh?=
 =?utf-8?B?RTZZSXRzZmZ4NEQ2cGNQSUpBcUdHb3BraFhUbFJ2aXFld1NIeHFaVXkrUEZO?=
 =?utf-8?B?QmFpRUxybk9JNUc0SDA3d3N3R0xhZHplc3cvLzkxUjRyK2prKy9WNks1MVc0?=
 =?utf-8?B?aWljcEpSdmlHQUJnM2ZOYVhxOGRQbnVGVG5ibmpkZHROQkhISFg1UTFlbCtv?=
 =?utf-8?B?MkIvT1lJN1JsMDdWZ0l1OFU4WGNjMkhSbERmbTJuM0tTQkxrcnlIVmRLZFN0?=
 =?utf-8?B?eDBoWGxvaWs3VnJnQmVweFZTMyt0bmJYK0pQNHZVcXBvMHhuc1RjbXFuSWhh?=
 =?utf-8?B?UmhpYVVkWWFlV2NRQWh2SDZiWmVzVW1aQmpOVlVNak1HS2VpMFptOTRVeFZV?=
 =?utf-8?B?a0pYb0NWeHI4Nk5NUGlMcjIzbzUwcG9UVlI3Njh5Y0RnRng2QmNpSUYyNUlF?=
 =?utf-8?B?ZURrTVN2OHVueHI5MDVoTElmZFYxam5EVUFnbmxKKzZXTWwwQVcwYjVsV0Zz?=
 =?utf-8?B?SjhzNHJYajFhaVFoOUdOTXZTd1Q5Q0pwTG1naHcxaUMrWFFhOVByaVVkNFlv?=
 =?utf-8?B?YkZsUDNtVTlNYTAzb2ZtV1A0M2llbzB5eDZnRlNzVU9ob0N5RnVDZE9mV2M1?=
 =?utf-8?B?WWRROGxVeWpiaHFsSnFFKzh5QU1ObDhMOVRXOHhTVE5SWWJvdURDMjJyUk5C?=
 =?utf-8?B?KzFlbVBqYmZhRHlEVW13TmxpWEJZY0l0TGk4Q2tmV0NTVEJZYXAwT0c1TFFB?=
 =?utf-8?Q?BnWoBz4/LE0laSX20LY1JT3iR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a492c7-bd12-425b-7619-08db6385fe29
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 16:25:34.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ntegogc21hNJSB7FCqjiXZtbCJu5DluWitAsZ+RDXsLrfJOC0xdWpnGNt+uENrKtu74mU7vYoXdSGZ8E8gF/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0703
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDIsIDIwMjMgNzo1NCBQ
TQ0KPiBUbzogU2F1cmFiaCBTaW5naCBTZW5nYXIgPHNzZW5nYXJAbWljcm9zb2Z0LmNvbT47IFNh
dXJhYmggU2VuZ2FyDQo+IDxzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb20+OyB0Z2x4QGxpbnV0
cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207DQo+IGJwQGFsaWVuOC5kZTsgZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgS1kgU3Jp
bml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPjsgd2VpLmxpdUBrZXJuZWwub3JnOyBEZXh1YW4gQ3VpDQo+IDxkZWN1aUBt
aWNyb3NvZnQuY29tPjsgTWljaGFlbCBLZWxsZXkgKExJTlVYKSA8bWlrZWxsZXlAbWljcm9zb2Z0
LmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh5cGVydkB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIDEvMl0geDg2L0tj
b25maWc6IEFsbG93DQo+IENPTkZJR19YODZfTVBQQVJTRSBkaXNhYmxlIGZvciBPRiBwbGF0Zm9y
bXMNCj4gDQo+IE9uIDYvMi8yMyAwNToyMiwgU2F1cmFiaCBTaW5naCBTZW5nYXIgd3JvdGU6DQo+
ID4gRnVydGhlcm1vcmUsIEkgd291bGQgbGlrZSB0byBsZWFybiBhYm91dCB0aGUgcmF0aW9uYWxl
IGJlaGluZA0KPiA+IGRpc2FsbG93aW5nIHRoZSBkaXNhYmxlbWVudCBvZiBDT05GSUdfWDg2X01Q
UEFSU0Ugd2hlbiBNUCB0YWJsZXMgYXJlDQo+ID4gbm90IGluIHVzZS4gQ29uc2lkZXJpbmcgdGhh
dCB3ZSBjb21waWxlIG91dCB0aGUgZmVhdHVyZXMgd2UgZG9uJ3QNCj4gPiBzdXBwb3J0LCB3b3Vs
ZG4ndCBpdCBiZSBhY2NlcHRhYmxlIHRvIGFsbG93IHVzZXJzIHRvIGN1c3RvbWl6ZSB0aGVpcg0K
PiA+IGNvbmZpZ3VyYXRpb25zIGluIHRoaXMgbWFubmVyPyBBbGxvd2luZyB0aGUgZGlzYWJsZW1l
bnQgb2YNCj4gPiBDT05GSUdfWDg2X01QUEFSU0Ugd291bGQgcHJvdmlkZSBncmVhdGVyIGZsZXhp
YmlsaXR5IGFuZCBlZmZpY2llbmN5IGZvcg0KPiB0aG9zZSB3aG8gZG8gbm90IHV0aWxpemUgTVAg
dGFibGVzLg0KPiANCj4gSWYgc29tZW9uZSBzZW50IGEgcGF0Y2gsIEknZCBjZXJ0YWlubHkgbG9v
ayBhbmQgZmlndXJlIG91dCB3aGF0ICJmbGV4aWJpbGl0eSIgYW5kDQo+ICJlZmZpY2llbmN5IiBp
dCB3b3VsZCBwcm92aWRlLiAgQnV0LCBob25lc3RseSwgaXQgd291bGQganVzdCBqdXN0IGJlIG5v
aXNlIGlmIGl0DQo+IGRvZXNuJ3Qgc29sdmUgYW4gX2FjdHVhbF8gcHJvYmxlbS4NCj4gDQo+IFdv
dWxkIGFueW9uZSBjYXJlIG9yIG5vdGljZSB0aGUgImZsZXhpYmlsaXR5IiBhbmQgImVmZmljaWVu
Y3kiIGl0IHdvdWxkDQo+IHByb3ZpZGU/DQoNCkFmdGVyIHRoZSBuZXcgYXBwcm9hY2ggd2UgaGF2
ZSBvcHRlZCwgSSBhZ3JlZSBpdCdzIG5vdCBibG9ja2luZyB1cyBmcm9tIGFueSBmdW5jdGlvbmFs
DQpwcm9ibGVtLiBBbHRob3VnaCBvbmUgb2YgdGhlIHRoaW5ncyB3ZSBhcmUgdHJ5aW5nIHRvIGFj
aGlldmUgaXMgdGhlIG1pbmltYWwga2VybmVsDQp3aGVyZSB3ZSB3YW50IHRvIHJlbW92ZSBhbGwg
dGhlIHVubmVjZXNzYXJ5IG9wdGlvbnMuIE91ciBzeXN0ZW0gaXMgbm90IGRlcGVuZGVudA0KTVBQ
QVJTRSBhbmQgd2UganVzdCBkb24ndCB3YW50IHRoaXMgY29kZSBpbiBvdXIgbWluaW1hbCBrZXJu
ZWwsIGFuZCB0aGlzIGNvbmZpZw0Kb3B0aW9uIGlzIHByZXZlbnRpbmcgdXMgZnJvbSByZW1vdmlu
ZyBpdC4NCg0KQWxzbywgaW4gcGFzdCBrZXJuZWwgaGFzIHByb3ZpZGVkIHRoaXMgZmxleGliaWxp
dHkgZm9yIG90aGVyIG9wdGlvbnMsIHdoaWNoIG1hZGUgbWUgdGhpbmsNCml0IGlzIGZpbmUgZG8g
aXQgZm9yIE9GIGFzIHdlbGwuDQpodHRwczovL2xrbWwuaW5kaWFuYS5lZHUvaHlwZXJtYWlsL2xp
bnV4L2tlcm5lbC8xMjEwLjMvMDE5ODcuaHRtbA0KDQpIYXBweSB0byBrbm93IHlvdXIgb3Bpbmlv
biBhbmQgbGVhcm4uDQo=
