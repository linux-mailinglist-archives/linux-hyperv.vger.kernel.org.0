Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A814861899C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 21:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKCUdu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 16:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKCUdt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 16:33:49 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020019.outbound.protection.outlook.com [52.101.51.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F94267A;
        Thu,  3 Nov 2022 13:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqAcsGbO6ABymuiqvdXSdAlvbDHcMR/LlVYJzXFZKSGYz6TylG4Uw/exUckDwkRnavY3TZnRx5FME5G+c0wb5UVasnUASP7nspB7AUmD8111rgcYdrqPgocCXobFJIClCd//JsIGowzo5mqEuH3JIGZBK+8lChLDLgcSx9YQV8Ilw9o2vor6aA6DfX7iOOjNGnLVhbH8E2djoeNcZRfBrf2jkWd7YFY9SFswTm6Nnq10yz+20YhIKIFswCYtSEpj2phLtN0z1wfMT6UU8D8wxH5N5ZZPkCqWKTR7HrIVNo6zZchwEB1M8f5eVD8bFTCvza+AJjOh9hba9dOihVqt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJoYKTezPLacuI/UyudJm1isKvuUKEbcgzZ9J1ex0us=;
 b=hmoalAZW/bdvQZG/xWK3XBIlJa9UGvthV2BjEAFvjgoiNb4eCiE8h22196fFH0jovUYmr6sTwhIAl81byWtITthpDKYfiGyOFFqPN8H3H+SjThaF9Y1xNq/8RkuI+kHqoAx2Sqy+V8mdwDK+huRDSUNReMLeQfNhsw1MS86nr4ReK2rGjQscx0PSCcV/7pB4cskVtwMjCo7cYcCQO36RFVVf8h75kFTUWn9Jjq8keN8rSXkFg+juKSjsDZE2vKe0j7Ltux0KnO5ZxQgS1vbFVPZv7tEIPgZ6wZEnLxd52V2FLClOBrG+efTfnFXTN791mXjxuEzy/KdZAUM+uWF8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJoYKTezPLacuI/UyudJm1isKvuUKEbcgzZ9J1ex0us=;
 b=DpgBw2faB+1mfIiUt+HB/tSQeD1Q3CQEU/dE3nAx+dYR/PKNa37fzIRTfBAnRxdVujD3Z00FV2qyys3wUwcChFYFVVpkM5V5CCpe/eTTd3fCPzxL8d4x4+xu1aKE5XrvhXTvFy501fs5WIE7QjjBMqfqsiyQorPRn+gsf6u6yMQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3580.namprd21.prod.outlook.com (2603:10b6:208:3d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.1; Thu, 3 Nov
 2022 20:33:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 20:33:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Topic: [PATCH v3 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Index: AQHY7635pOXjdMrlWEeUmnmc1+6tfq4toZHA
Date:   Thu, 3 Nov 2022 20:33:40 +0000
Message-ID: <BYAPR21MB1688F63C2410904F92B1F75FD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749834466.218190.3482871684875422987.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166749834466.218190.3482871684875422987.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bfae6d0-b96b-413c-b3b2-a956c9c9193f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T20:11:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3580:EE_
x-ms-office365-filtering-correlation-id: d0b43576-ac7e-46e9-6290-08dabddab1d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5I6UZHDkXEIoc9bV2bzwf6JUlAtIodWmVPJNYW8J60Sb9pDhSuY0ODnjgtKn7rwQtAFBR6aQVj7wfSA8c2SXfI6C0rgkPTi+Zn0te06X/V5al8HIo9Oz7Un4kFxdf4ASeI73H7FIWgD32El2FOQOR5MV4EueKFkwLgx2r5q6B1w7/enUI8mpocy0RViKtOlhDkojy+5+q+qi5lDWSKy+DUN69CM7ge8z0wWxh8x18Y5Xt1UwsDL+sx5uaZHZkd8x6NH2t39HhiYIHHeq32FMJgBbBd2m1LRhTcG6eNxB43BOh/uU37k4TCrYgsEhWglaaIhZTjQODmks33VYz6rC/XyEJaqMCHnMqstfNY+/qdl0Z3KcX2aml+IDB2Gb3k7Qq60rHJoz+s1GX4dI9p7c3TrQOZfW9kdfbPMgepYSFTUaKwiFvs4/O2rJFkftFAB6udZ1s0FnXQCOMPzIBBDl4AVE9QbKRG69aywZHZJO2/syzS3MwG8jach/KpQNj6lxz/GYP9o5qHYNFma1h9DqrXDOaD1x9vXRQUVlVhzTaf0N4yfYnuFwFnA7EgoIDniqji/Kyk3TlL+ceol0OIl31uI9or80nz5vrA3fbND9k32H64Mk+p7btH8whXNbV7buOEWY3EmWrmm05i71ywHwyWy1joxQmxSrvecDqW9ELQnm1DjC6G0xDVgq6bNTNXdScUwB8M/iQUXSMNBXoqCnQASnC2wifvnfbPo8vzG/9vTQac77xfxAiQxgcJym6rTOXRkeTnMzfmAG06dWxDkbT4TtZH2iBYgLj+a9I4Z/wLdus7CL4WlukJ4nZqGnoH5V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(8936002)(41300700001)(6862004)(82950400001)(2906002)(86362001)(33656002)(7416002)(54906003)(52536014)(8990500004)(38100700002)(5660300002)(10290500003)(122000001)(71200400001)(76116006)(82960400001)(478600001)(7696005)(26005)(9686003)(83380400001)(38070700005)(55016003)(6506007)(66476007)(64756008)(8676002)(66556008)(4326008)(66946007)(66446008)(316002)(66899015)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3J6WnhoV1RVOTVTWjJEOW9wdHJiV2MrMzZsbVl0MmoxQnczTk9EK1doRnVT?=
 =?utf-8?B?dTd2eG5Tb3JRY1hjRTBudXFjN0VNcVk3L204NTBjdTlLb3FiS3VUY0x5anNY?=
 =?utf-8?B?N3dxSFh0bFd2UVAzSWIxY015cVFOMmR5aVhmNTlCYjQrTFRRMlF0VGpGRWF5?=
 =?utf-8?B?REl5aEFzNDdmQUVxNEhvWmkwbHNCUTByaTk0cCtieXR4NWRXcERTMTZ5Q2M5?=
 =?utf-8?B?bU9kNHdlTmZROHhhMHdyMC82TWQ3ZmhZY0srRE1CNDJRQ3VGOGVteE5nc2ZN?=
 =?utf-8?B?cEpPS2s4dkNwWUdxWDR0ZjZLck1Qb05tbjFsOUJHa2VhVEEzaWFtenNGY25U?=
 =?utf-8?B?ZGZrOGltcDlyVGhUN25xMFRIK2pRYnlJSGJXU21QMU5lSWR1dlI3QnlHeUQ3?=
 =?utf-8?B?L1FEVExiUlB4VzBlT2Q0SkpjNEhvbjQ2TXcxd0ovZG9tMU5jZ3YrWFVxTHJt?=
 =?utf-8?B?SFVRODlQQnZqZy8zb1hyY05mOVdZNzFud1Y1V0NQV25QRUJCTXJSeHNCMkc3?=
 =?utf-8?B?VUdrN0xHY25BT01zWWZaR3pFWElnTWZvWDltOFFxWnRhUHJ5Q1E0Zk4wRk9C?=
 =?utf-8?B?cU9RTml0RGRpSVEveGxwbWhSNGs2dm1rakhkYWoxdlVEYzlOUWZ4eHlMSkh1?=
 =?utf-8?B?V0VkdFdNbnVUb3dXTTFTMWMwZmMxdll2a3U4Q3duaW5OOGNXd1R3aWE3YlFO?=
 =?utf-8?B?TlJ4enVRaG9DWjNWSE5JUnZsejh4SVZ3aXJsWVVITnhuUDFUV0VIcHRmU1h1?=
 =?utf-8?B?WktqUXNuRkNybkdPcWFRUUY2Ym8rSmN3R2FySVozUzJkemxxODRld2V4T081?=
 =?utf-8?B?WmdVamZ6QVVlRTRrUmhxakJIMHJKc2FIYWdraEdpb2RvSmpod2RVR29kTkhl?=
 =?utf-8?B?WW5mdTJ1UXZOS3cyd0hpNHMwMFVDVnkzbFNRRFVwSlViQmtHcWhNekFEeHJZ?=
 =?utf-8?B?QjJpZmVOSVZWOHdseGVkcWlVblpnclpPR3VHZHZDTnNqWnNsNDJLSS9KZnQ2?=
 =?utf-8?B?N3VLVHJxZWpWWXR2WkRSRDdxNlhVVnZWSE5yZzNGNnhHTGNJVzMwcCt3MnFL?=
 =?utf-8?B?bmlMQUg4NGhoa1BsNVFKYkE0QzBlVjF2NkpMWXgrNVlUOHJjUWpzLzByejBG?=
 =?utf-8?B?ei9ySUlkZk10Uk9mS2M5K2psVFowZEJvNUpxQWxCS0dwZElVbTBWRlhwRXQr?=
 =?utf-8?B?Uzk2TkFjK2xxTk00OFhDRXZ5OUEzc3lRSzlpM0lWZVhYa3dScjRvSWRlZ1Iy?=
 =?utf-8?B?clV6UmZ3bkpTWUlpaENQWElkZS9nVzdFZGl3QXhISmQwdWJ6blhSMnBBNTEz?=
 =?utf-8?B?MmZabEl3SWFBb0Y4c0I5anlCdzRVbDhUdGQ0M2R2L0wzblM2U3BrSnFtam1z?=
 =?utf-8?B?Zkt3b1VRRFJxdTE5eVNHV0xkZVRtR3VJK2RZaDhDMS9WV1NuVkdtSVp4OWgy?=
 =?utf-8?B?czF1SFNWNUZJTVBwaG4xYWt5Z1ZIaENWZTJQeXNiQzRCUUpRTDlaT1loV2tm?=
 =?utf-8?B?b1hHMkU5VHRURUlscU9KZnhGbUhxSFNEK1g2c1l2TUt1Q1YvRElUTk9LUXlW?=
 =?utf-8?B?RHVMLzhjWFoySFZWQUhBWUJHOC80bWY4OTNIVXk4M01LRG1NNUs5K0lmanNl?=
 =?utf-8?B?YndNbmdQUmRRZXhGZC96TCtuOURUbWNWKy9CQ1BxVVVxeTNCUjVkZEJwRG5x?=
 =?utf-8?B?Qkt2cWtJWTNjelgzN3lLRlpUT3lCMUE2WGFqUzlFbTd1Y1NPdlUrU2hNYUh4?=
 =?utf-8?B?cFNRbEtVT1ZVT2hDL01KSVFpUHVGOE9vMzc0aTNmWjczNWVMc1ZoRHFTcW03?=
 =?utf-8?B?Mm9wOFk2SzRscHZreHVkbmVZWU8xUlNHbjFVSjFmYVhxVGpZbHdnblpuNDNW?=
 =?utf-8?B?S0xMbDFibmZlcW1hMFkyQUhUZUZrTWlGcjNjMXBReWl1eHU1bndvYUQrNndX?=
 =?utf-8?B?OUR6Q1BRVm5pdDd4bStvc1FhdUhBQldMV0w5YyszcWt1elhkTWRQd0xmUGhB?=
 =?utf-8?B?VzZmenBrVWJNelFnWWxic0hNOCsvaW5Ea3U4cXJiWmtkN1lLTDNGSEJxWVA2?=
 =?utf-8?B?WGpyYlc1ZXZyM3hKY1JEbG5xa2tHQnIySVRMOFNyTzVpd2VBd3E4SEFKWXdi?=
 =?utf-8?B?U0ppcFVZeDJ2Z2ZKQ1lwc3ZoTW5oblFpbFRJRzlHSE9MZUxPaGlDZThCdkNu?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b43576-ac7e-46e9-6290-08dabddab1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 20:33:40.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eocVMDiAxytzrgd1kWkzaeJ/Hfxn6/xZb08+cKd+DkPY6QZInHTT3F3uqKtrf6tDI8rYzygcBocU94EF1IAtJX2JBikkWz04ZsDcWV3u/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3580
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
LmNvbT4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMsIDIwMjIgMTA6NTkgQU0NCj4gDQo+IE1p
Y3Jvc29mdCBIeXBlcnZpc29yIHJvb3QgcGFydGl0aW9uIGhhcyB0byBtYXAgdGhlIFRTQyBwYWdl
IHNwZWNpZmllZA0KPiBieSB0aGUgaHlwZXJ2aXNvciwgaW5zdGVhZCBvZiBwcm92aWRpbmcgdGhl
IHBhZ2UgdG8gdGhlIGh5cGVydmlzb3IgbGlrZQ0KPiBpdCdzIGRvbmUgaW4gdGhlIGd1ZXN0IHBh
cnRpdGlvbnMuDQo+IA0KPiBIb3dldmVyLCBpdCdzIHRvbyBlYXJseSB0byBtYXAgdGhlIHBhZ2Ug
d2hlbiB0aGUgY2xvY2sgaXMgaW5pdGlhbGl6ZWQsIHNvLCB0aGUNCj4gYWN0dWFsIG1hcHBpbmcg
aXMgaGFwcGVuaW5nIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNi
dXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBDQzogIksuIFkuIFNy
aW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IEhhaXlhbmcgWmhhbmcgPGhhaXlh
bmd6QG1pY3Jvc29mdC5jb20+DQo+IENDOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+
IENDOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDQzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT4NCj4gQ0M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDQzogRGF2ZSBI
YW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ0M6IHg4NkBrZXJuZWwub3Jn
DQo+IENDOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDQzogRGFuaWVsIExl
emNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENDOiBsaW51eC1oeXBlcnZAdmdl
ci5rZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0K
PiAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAgICAgICAgICB8ICAgIDIgKysNCj4gIGRyaXZl
cnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgfCAgIDM4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCB8
ICAgIDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMgYi9hcmNo
L3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+IGluZGV4IGY0OWJjM2VjNzZlNi4uODk5NTQ0OTBhZjkz
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ICsrKyBiL2FyY2gv
eDg2L2h5cGVydi9odl9pbml0LmMNCj4gQEAgLTQ2NCw2ICs0NjQsOCBAQCB2b2lkIF9faW5pdCBo
eXBlcnZfaW5pdCh2b2lkKQ0KPiAgCQlCVUdfT04oIXNyYyk7DQo+ICAJCW1lbWNweV90b19wYWdl
KHBnLCAwLCBzcmMsIEhWX0hZUF9QQUdFX1NJWkUpOw0KPiAgCQltZW11bm1hcChzcmMpOw0KPiAr
DQo+ICsJCWh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSgpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWh5
cGVyY2FsbF9tc3IuZ3Vlc3RfcGh5c2ljYWxfYWRkcmVzcyA9DQo+IHZtYWxsb2NfdG9fcGZuKGh2
X2h5cGVyY2FsbF9wZyk7DQo+ICAJCXdybXNybChIVl9YNjRfTVNSX0hZUEVSQ0FMTCwgaHlwZXJj
YWxsX21zci5hc191aW50NjQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9o
eXBlcnZfdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gaW5k
ZXggOTQ0NWExNTU4ZmU5Li5kZWM3YWQzYjg1YmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBl
cnZfdGltZXIuYw0KPiBAQCAtNTA5LDkgKzUwOSw2IEBAIHN0YXRpYyBib29sIF9faW5pdCBodl9p
bml0X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAm
IEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRSkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4g
DQo+IC0JaWYgKGh2X3Jvb3RfcGFydGl0aW9uKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4g
IAkvKg0KPiAgCSAqIElmIEh5cGVyLVYgb2ZmZXJzIFRTQ19JTlZBUklBTlQsIHRoZW4gdGhlIHZp
cnR1YWxpemVkIFRTQyBjb3JyZWN0bHkNCj4gIAkgKiBoYW5kbGVzIGZyZXF1ZW5jeSBhbmQgb2Zm
c2V0IGNoYW5nZXMgZHVlIHRvIGxpdmUgbWlncmF0aW9uLA0KPiBAQCAtNTI5LDE2ICs1MjYsMjIg
QEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nrc291cmNlKHZvaWQpDQo+ICAJ
fQ0KPiANCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVyID0gcmVhZF9odl9jbG9ja190c2M7
DQo+IC0JdHNjX3BmbiA9IEhWUEZOX0RPV04odmlydF90b19waHlzKHRzY19wYWdlKSk7DQo+IA0K
PiAgCS8qDQo+IC0JICogVGhlIEh5cGVyLVYgVExGUyBzcGVjaWZpZXMgdG8gcHJlc2VydmUgdGhl
IHZhbHVlIG9mIHJlc2VydmVkDQo+IC0JICogYml0cyBpbiByZWdpc3RlcnMuIFNvIHJlYWQgdGhl
IGV4aXN0aW5nIHZhbHVlLCBwcmVzZXJ2ZSB0aGUNCj4gLQkgKiBsb3cgb3JkZXIgMTIgYml0cywg
YW5kIGFkZCBpbiB0aGUgZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzcw0KPiAtCSAqICh3aGljaCBhbHJl
YWR5IGhhcyBhdCBsZWFzdCB0aGUgbG93IDEyIGJpdHMgc2V0IHRvIHplcm8gc2luY2UNCj4gLQkg
KiBpdCBpcyBwYWdlIGFsaWduZWQpLiBBbHNvIHNldCB0aGUgImVuYWJsZSIgYml0LCB3aGljaCBp
cyBiaXQgMC4NCj4gKwkgKiBUU0MgcGFnZSBtYXBwaW5nIHdvcmtzIGRpZmZlcmVudGx5IGluIHJv
b3QgY29tcGFyZWQgdG8gZ3Vlc3QuDQo+ICsJICogLSBJbiBndWVzdCBwYXJ0aXRpb24gdGhlIGd1
ZXN0IFBGTiBoYXMgdG8gYmUgcGFzc2VkIHRvIHRoZQ0KPiArCSAqICAgaHlwZXJ2aXNvci4NCj4g
KwkgKiAtIEluIHJvb3QgcGFydGl0aW9uIGl0J3Mgb3RoZXIgd2F5IGFyb3VuZDogaXQgaGFzIHRv
IG1hcCB0aGUgUEZODQo+ICsJICogICBwcm92aWRlZCBieSB0aGUgaHlwZXJ2aXNvci4NCj4gKwkg
KiAgIEJ1dCBpdCBjYW4ndCBiZSBtYXBwZWQgcmlnaHQgaGVyZSBhcyBpdCdzIHRvbyBlYXJseSBh
bmQgTU1VIGlzbid0DQo+ICsJICogICByZWFkeSB5ZXQuIFNvLCB3ZSBvbmx5IHNldCB0aGUgZW5h
YmxlIGJpdCBoZXJlIGFuZCB3aWxsIHJlbWFwIHRoZQ0KPiArCSAqICAgcGFnZSBsYXRlciBpbiBo
dl9yZW1hcF90c2NfY2xvY2tzb3VyY2UoKS4NCj4gIAkgKi8NCj4gIAl0c2NfbXNyLmFzX3VpbnQ2
NCA9IGh2X2dldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDKTsNCj4gKwlpZiAo
aHZfcm9vdF9wYXJ0aXRpb24pDQo+ICsJCXRzY19wZm4gPSB0c2NfbXNyLnBmbjsNCj4gKwllbHNl
DQo+ICsJCXRzY19wZm4gPSBIVlBGTl9ET1dOKHZpcnRfdG9fcGh5cyh0c2NfcGFnZSkpOw0KPiAg
CXRzY19tc3IuZW5hYmxlID0gMTsNCj4gIAl0c2NfbXNyLnBmbiA9IHRzY19wZm47DQo+ICAJaHZf
c2V0X3JlZ2lzdGVyKEhWX1JFR0lTVEVSX1JFRkVSRU5DRV9UU0MsIHRzY19tc3IuYXNfdWludDY0
KTsNCg0KVGhlcmUncyBhIHN1YnRsZXR5IGhlcmUgdGhhdCB3YXMgbmFnZ2luZyBtZSwgYW5kIEkg
dGhpbmsgSSBzZWUgaXQgbm93Lg0KDQpBdCB0aGlzIHBvaW50LCB0aGUgY29kZSBoYXMgZW5hYmxl
ZCB0aGUgUmVmZXJlbmNlIFRTQywgYW5kIGlmIHdlJ3JlIHRoZSByb290DQpwYXJ0aXRpb24sIHRo
ZSBSZWZlcmVuY2UgVFNDIFBhZ2UgaXMgdGhlIHBhZ2Ugc3VwcGxpZWQgYnkgdGhlIGh5cGVydmlz
b3IuDQp0c2NfcGZuIGhhcyBiZWVuIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGF0IGh5cGVydmlzb3Ig
c3VwcGxpZWQgcGFnZS4NCg0KQnV0IHRzY19wYWdlIGhhcyBub3QgYmVlbiB1cGRhdGVkIHRvIGJl
IGluIHN5bmMgd2l0aCB0c2NfcGZuIGJlY2F1c2Ugd2UNCmNhbid0IGRvIHRoZSBtZW1yZW1hcCgp
IGhlcmUuICB0c2NfcGFnZSBzdGlsbCBwb2ludHMgdG8gdHNjX3BnLCB3aGljaCBpcyBhDQpnbG9i
YWwgdmFyaWFibGUgaW4gTGludXguICB0c2NfcGFnZSBhbmQgdHNjX3BmbiB3aWxsIGJlIG91dC1v
Zi0gc3luYyB1bnRpbA0KaHZfcmVtYXBfdHNjX2Nsb2Nrc291cmNlKCkgaXMgY2FsbGVkIGxhdGVy
IGluIHRoZSBib290IHByb2Nlc3MuICBEdXJpbmcNCnRoaXMgaW50ZXJ2YWwsIGNhbGxzIHRvIGdl
dCB0aGUgSHlwZXItViBSZWZlcmVuY2UgVFNDIHZhbHVlIHdpbGwgdXNlIHRzY19wZywNCm5vdCBv
biB0aGUgUmVmZXJlbmNlIFRTQyBQYWdlIHRoYXQgdGhlIGh5cGVydmlzb3IgaXMgdXNpbmcuICBG
b3J0dW5hdGVseSwNCnRoZSBmdW5jdGlvbiBodl9yZWFkX3RzY19wYWdlX3RzYygpLCB3aGljaCBh
Y3R1YWxseSByZWFkcyB0aGUgUmVmZXJlbmNlDQpUU0MgUGFnZSwgdHJlYXRzIGEgemVybyB2YWx1
ZSBmb3IgdHNjX3NlcXVlbmNlIGFzIGEgc3BlY2lhbCBjYXNlIG1lYW5pbmcNCnRoYXQgdGhlIFJl
ZmVyZW5jZSBUU0MgcGFnZSBpc24ndCB2YWxpZC4gIHJlYWRfaHZfY2xvY2tfdHNjKCkgdGhlbiBm
YWxscw0KYmFjayB0byByZWFkaW5nIGEgaHlwZXJ2aXNvciBwcm92aWRlZCBzeW50aGV0aWMgTVNS
IHRvIGdldCB0aGUgY29ycmVjdA0KUmVmZXJlbmNlIFRTQyB2YWx1ZS4gIFRoYXQgZmFsbGJhY2sg
aXMgZmluZSAtLSBpdCdzIGp1c3Qgc2xvd2VyIGJlY2F1c2UgaXQNCnRyYXBzIHRvIHRoZSBoeXBl
cnZpc29yLiAgQW5kIHRoZSBmYWxsYmFjayB3aWxsIG5vIGxvbmdlciBiZSB1c2VkIG9uY2UgDQp0
c2NfcGFnZSBpcyB1cGRhdGVkIGJ5IGh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSgpLg0KDQpTbyB0
aGUgY29kZSB3b3Jrcy4gUHJlc3VtYWJseSB0aGlzIHN1YnRsZXR5IHdhcyBhbHJlYWR5IHVuZGVy
c3Rvb2QsIGJ1dA0KaXQgcmVhbGx5IHNob3VsZCBiZSBjYWxsZWQgb3V0IGluIGEgY29tbWVudCwg
YXMgaXQgaXMgZmFyIGZyb20gb2J2aW91cy4gIEkNCmtub3cgdGhpcyBjb2RlIHByZXR0eSB3ZWxs
IGFuZCBJIGp1c3QgZmlndXJlZCBpdCBvdXQuIDotKA0KDQpNaWNoYWVsDQoNCj4gQEAgLTU3Mywz
ICs1NzYsMjAgQEAgdm9pZCBfX2luaXQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCWh2
X3NjaGVkX2Nsb2NrX29mZnNldCA9IGh2X3JlYWRfcmVmZXJlbmNlX2NvdW50ZXIoKTsNCj4gIAlo
dl9zZXR1cF9zY2hlZF9jbG9jayhyZWFkX2h2X3NjaGVkX2Nsb2NrX21zcik7DQo+ICB9DQo+ICsN
Cj4gK3ZvaWQgX19pbml0IGh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiArew0KPiAr
CWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAmIEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJM
RSkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmICghaHZfcm9vdF9wYXJ0aXRpb24pIHsNCj4g
KwkJV0FSTigxLCAiJXM6IGF0dGVtcHQgdG8gcmVtYXAgVFNDIHBhZ2UgaW4gZ3Vlc3QgcGFydGl0
aW9uXG4iLA0KPiArCQkgICAgIF9fZnVuY19fKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0K
PiArCXRzY19wYWdlID0gbWVtcmVtYXAodHNjX3BmbiA8PCBIVl9IWVBfUEFHRV9TSElGVCwgc2l6
ZW9mKHRzY19wZyksDQo+ICsJCQkgICAgTUVNUkVNQVBfV0IpOw0KPiArCWlmICghdHNjX3BhZ2Up
DQo+ICsJCXByX2VycigiRmFpbGVkIHRvIHJlbWFwIEh5cGVyLVYgVFNDIHBhZ2UuXG4iKTsNCj4g
K30NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4g
Yi9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQo+IGluZGV4IDMwNzhkMjNmYWFl
YS4uNzgzNzAxYTIxMDJkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVy
dl90aW1lci5oDQo+ICsrKyBiL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4g
QEAgLTMxLDYgKzMxLDcgQEAgZXh0ZXJuIHZvaWQgaHZfc3RpbWVyX2dsb2JhbF9jbGVhbnVwKHZv
aWQpOw0KPiAgZXh0ZXJuIHZvaWQgaHZfc3RpbWVyMF9pc3Iodm9pZCk7DQo+IA0KPiAgZXh0ZXJu
IHZvaWQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIGh2X3JlbWFw
X3RzY19jbG9ja3NvdXJjZSh2b2lkKTsNCj4gDQo+ICBleHRlcm4gdW5zaWduZWQgbG9uZyBodl9n
ZXRfdHNjX3Bmbih2b2lkKTsNCj4gIGV4dGVybiBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpo
dl9nZXRfdHNjX3BhZ2Uodm9pZCk7DQo+IA0KDQo=
