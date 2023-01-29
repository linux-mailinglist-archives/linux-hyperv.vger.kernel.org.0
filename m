Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8367FCBF
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Jan 2023 05:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjA2Ehe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Jan 2023 23:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Ehc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Jan 2023 23:37:32 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888521A27;
        Sat, 28 Jan 2023 20:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFlNEhRQXW9QpIUgum1hz4BimUL1eXRQLW0nfFVb76TP5QF9O2c1kyLY0nqojlHfIUxbm/M83hWbAwjZ3z1rvOBelJGGNUG0wlrIcriCN/ON4yHrkstbMewKW+z4gZbpt1nUQh46xHAV2+rNqMkQIR4FJhVXR7aYCDE8vHtzNWjH7VvZOlyC1kf+SXCemePnkpM04Gkp1W/lZH9XEE5I6beJlPCZu6JW1p01pGtwxEumT/5w0ekKbZyeFeDXZcOwl3OuvY5f3FpzQyfJVWUqBx9Z/Ky0yLuFCqvO0WLJ17amw0d7ulodFm3XfOWbkS602r/qcFLqYw2+zFaxd9ar5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W15XxMT+aWU34UfRZjqdkpfDC5x4FJuBpKkHFljcQ3E=;
 b=Fi8IK6hUlj/J5jsS2NxDSUmKLfY7oFRdDOvFNw+/bsBRFFUUEPGAwlBboBA7fQndkRCv/k87EYnuGKnnXq79XUvrYcFhn8YWFPl5zkuvzc7zvh6LvGHAkblvtqHn4yS/6g5bV74/C+P9KUHfnFxXj9rc8oTVIl9TX4lwBQkKqbPq7zsSpALcoE0DNwbOGPBBgMJ/NmtSdige7sJ0Pn7RYiv3AZGXZtebuFuM/1VniWr5TCHSyF+/e8Ca4wthDhGQHm0sfgF41xJGTON7WTN83Ol6bjsH3nGUinZZ1m+qAPFxNaPNsrJml6WBi70F8olISJknuqHEwTrHf/VrdM7fKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W15XxMT+aWU34UfRZjqdkpfDC5x4FJuBpKkHFljcQ3E=;
 b=gnzDoSMzcQyNENROC1etEmOl8VSEosK6Lw7zqY4iAfuWnSDWC0AwnwnzYkfAW0FdSPe6ANPmnEX9kyjreqZZZF76XXpoX8Z4dKLaTuJ2BYb4pdlvX2R71/Nbru4M08gqkDZcXWyTTuuhsCCggufdU5gan0hcNroRkr6j5ryKtbs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3541.namprd21.prod.outlook.com (2603:10b6:930:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.4; Sun, 29 Jan
 2023 04:37:25 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%6]) with mapi id 15.20.6064.019; Sun, 29 Jan 2023
 04:37:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [RFC PATCH v1 3/6] x86/sev: Maintain shadow rmptable on Hyper-V
Thread-Topic: [RFC PATCH v1 3/6] x86/sev: Maintain shadow rmptable on Hyper-V
Thread-Index: AQHZL0sDN7ZxmWp51UOcXi2qY38cP6601TSw
Date:   Sun, 29 Jan 2023 04:37:24 +0000
Message-ID: <BYAPR21MB1688B068954CEB8A2B4DEA73D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-4-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230123165128.28185-4-jpiotrowski@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48df628d-ded6-4480-a2e3-073dc3b839c7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-29T04:26:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3541:EE_
x-ms-office365-filtering-correlation-id: b2977d59-3e92-4467-00ab-08db01b284bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsuC5AVMzWuScgxTXNQ6stb6UIBLVZB/BOv5r6WzUmZfr1VXipQeiz5hgOtKnVArgLHYmUFf1wI8gnfJZ4PdBqnE7x5LiW8FgQpODqNFCRlIuZMW6jR71HAxuIw2Rzq0BAFgofqjpq5sVkz7iYHNi6TTl6y/wa6mW+6zR1EfvORqQmB8coAI/AN5dedMmyjz1fbU5LajnerCb7LL24xpVe6d53/+1YcS+Boyj1QbV67o5WhKNgrEOWBixL9s0qqzJ5XQR2I9Y4LfACukpfri5R2V6uu6+kBY7MfnFpwuRzpruspqxETF5y1gSifUArv4FRlZaDh7xCBDEL/IQGTRI2iyzIoOTwMA4yZxx3LIFnCKtqbH8CdBgdUHqyV6/85hST09v2DvMjL24juY9138jM2RpPjyyeJ5nEW6AaN+wE1m8NRwqNkEQNxdhZjmO9f0ctwuIgKFy83Z8A71yifl7qh1Xp9nDghozh436WVbKLLfGM5wXMJNeJKV2afGLTTK+ozaeeB4wEqb6xWR0V9oTMeQAYNH90zNdS8pwIMPxTUBjQP3Z0mnpNPN2TA5h4/AjP6AHBT8MA7KQALHa6NwDw5beDQGvFOW5wHhYqGUDdsCpcfD3XAGopSsa+/ccNoGFDRfeIWdpdjdAcutJYQSnfUlN9vr60glYMlUPCV3iRlywrhyRBqmk/30bV6bRIzvodhZZRDCN6en1k1LHMRqfTMeJJlztoO958wPcYhn6qdKjrxDGpMkFW74/71TGeXo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(64756008)(82950400001)(66899018)(5660300002)(122000001)(38100700002)(7416002)(52536014)(76116006)(41300700001)(4326008)(2906002)(8936002)(66476007)(82960400001)(26005)(9686003)(66556008)(6506007)(8676002)(33656002)(55016003)(186003)(66946007)(110136005)(38070700005)(66446008)(316002)(8990500004)(71200400001)(7696005)(54906003)(83380400001)(478600001)(86362001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3FCQVMzMW5OOG13ZXF2T0hiOUI4M2N5RmROZjVvZVh5Y0ZlTkQ4ODU4Vy9I?=
 =?utf-8?B?dDlLbmhkTG04Njdxc1Njbms5NXBGRXcra1RzTUdIYThvS20rcTlvNlBHamt1?=
 =?utf-8?B?dUZEenk4czdCOGUySXNYcEphOFZCU1JDTXNyc2NvUmRNUnpicm5HYkNBL3Zx?=
 =?utf-8?B?eHRKWXVMWHlKQU5PMU1nYzVLK2VQS2cwVW16L0lSU3VhRVFyOVlrOUxJQTlv?=
 =?utf-8?B?TjhWU0k3NXV1ektwUXhLUDd6TXZsSGd5QlVab04rTnY5d1ByNDVyTW8vR0Zs?=
 =?utf-8?B?VUNKUTA3Zng5OUFZOVZycDVMTFZQQ2tETWpiNFpxNUFjcTUvOEk1SEU4Slh4?=
 =?utf-8?B?SCtxeUd3Rzc0RGZvazRaZnkvUEdHRmxJeFJkdnJQSnAxM1g1dFJ1cWE2VnBk?=
 =?utf-8?B?bUFTN2Q4NEF0OER2bHhoelREd0FYVG1Tam5aL1hYZkxzUGs5M1F2enlqME1S?=
 =?utf-8?B?bVNtZjdxb0NHc1lKQXZoQmJwMFZaR0NsWTB2ZDVhQ3FmQWtKUU5NcWhodjJ5?=
 =?utf-8?B?cExHY3N3WjNxWmFuMXlnWnlXSEVNNlh2ZUpSYzFPTGhySmY2UkFUdG1ESkQz?=
 =?utf-8?B?WDdWMVFxWk90WThtUmNUelJ2blg5Ry84cVd2MGpPZ05BTSsrbG51Mld5MXR1?=
 =?utf-8?B?SFJVTGpPMXVLVEFpaGpmQ3l4di9nVlBqQ0xvbUFrUEcyUlZ6bmd0TjFzNUZw?=
 =?utf-8?B?SmtsSkplZjFEb1RKcWF5NU1GdUxxK2NrekxLZFhoamxYVVBDVHd0VjJWMThC?=
 =?utf-8?B?ayszdW4rcXZGZFF5cHJBYUpabjlhOEE0S3d2QjNLeXdOR0c3Z2hBekRualRz?=
 =?utf-8?B?R0xaYUJSY3NvSi9jRG93L2RDNVo4UTEzRmdKWFNNV1kyOEZxNkswUmRQK2Yy?=
 =?utf-8?B?TklBRnV0UnVtbE10YTdCZGV0Nmtxa3RYWjZuaG1ubUJyVUcvUnhqeFRrS1FE?=
 =?utf-8?B?VG1sendBeURlUGdSN0I2MDlnK3NIYUUwdE1BbGZYWDdzQ1Q0RzNrbmZWRHpk?=
 =?utf-8?B?bUR5NUNyMXZMaWtvRFFieHE3T3owVXF1cnc3QUlCblJ5V0tOeTJHM1FyWU0z?=
 =?utf-8?B?a3ZabHZGOFpmVXFkMWtNdmZjck8rQjFPOXRxNTBIV2ZTREp1eTh2OXFPV0Vz?=
 =?utf-8?B?ZUJ4ckVEb3BHMkRybXlsQWJLNDNjSG1QSUVlOGI5SW0yd1dGdFJKRGkwU01V?=
 =?utf-8?B?SE03UWVSWmE4OVBoZ2dTWEY4cXYrSlJlNWdLK1dDd0lYMUc1OGlLaU9TS0tT?=
 =?utf-8?B?OUFlWFNZT0phYTVzWkd1TkFobEpxbEhTRjN2d1Z0T0NJYjNqSWgrVXlJcXVm?=
 =?utf-8?B?SzBEZUxIN2xsK2xjMHFOOEhIQlZDVmI3L2Y4dVZ3cjNxTXFsemZnMGtpcTVE?=
 =?utf-8?B?TmpZYk13eVJaZDN6djZGZGM1ekFibGs4MjQxUXFQd0syQ2NXdzhwdnkxTnln?=
 =?utf-8?B?MWJ2K0s5clJLa3U0QkNNcUNxY2V1UE1XcjlvbUxheDlwWlhRRzFEVlBWNS83?=
 =?utf-8?B?M08xVCt4eXU5L3hFMEtLQWkwWmk1NmgxUVJHamlzWTArUUF3WHU0N2tvbGVr?=
 =?utf-8?B?cEpFVjg4alp2QU9JZGh2YXNaam8wRnNOcVZQOUI2MTB4Z2RGR09tZnA2Z1E3?=
 =?utf-8?B?Q0F5a3diWUZCbU9SVzJGT3pISVQ4elA5TEFLcTM1ZHBYNml2NmF5MEVIUWhq?=
 =?utf-8?B?U25rV1g3d2poL2I4Z1NsZ0JhblNTWDJDVzR2R1Jod1ltZXNUV1JFSnpoeG1J?=
 =?utf-8?B?VGl0elNCaUp2cW5VWCtWb3BSdVY0ckVKNmZ1MFNibHVVWFdyVG9wV01FNDN0?=
 =?utf-8?B?ZWZEL3lTVWZWYVFmclRhaW5GcFc3Rm5hZ1YyTlNDNGN4bDlYK0VGbmhuOGQy?=
 =?utf-8?B?NndPQnNjeWFzN0szcWhzOGNKRGlFTEZkQjNva3h6YXhCRlRGYVEyYkxKN0c0?=
 =?utf-8?B?L0liRWZrSUxZYlVqaDBNY1Q2Q0F6R0NWNThKVnA4Wk83emR1amJaOHYrbzZW?=
 =?utf-8?B?REpiTlA1bitrQlpoZHE3aXd6R0t4cDU0WGJmVGxXNVV5QXNpOVRsZzBWT0dh?=
 =?utf-8?B?dXpLejNySEZwbEtkT1FaUkwxcFVHd25odGVLS0dnTHB6dlVkUGdtNDJlQUZz?=
 =?utf-8?B?Y3gzeFBaMkxET015ck8zK1lMTDdOb1FZMDRRa1FOcXF3UnlVcU9JUDJtUGYz?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2977d59-3e92-4467-00ab-08db01b284bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 04:37:24.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AAKVCX/2WzRGyyyiSPAxQPX6ICVOk5WGV8TCM+Pv5F3jrbXSlZImVPDPn4KRgsgJgXzKRw5wG3mCaoN1Qo1SUC32j1oXoUZGiBCBZgIpE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSmVyZW1pIFBpb3Ryb3dza2kgPGpwaW90cm93c2tpQGxpbnV4Lm1pY3Jvc29mdC5jb20+
IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyMywgMjAyMyA4OjUxIEFNDQo+IA0KPiBIeXBlci1WIGNh
biBleHBvc2UgdGhlIFNFVi1TTlAgZmVhdHVyZSB0byBndWVzdHMsIGFuZCBtYW5hZ2VzIHRoZQ0K
PiBzeXN0ZW0td2lkZSBSTVAgKFJldmVyc2UgTWFwKSB0YWJsZS4gVGhlIFNOUCBpbXBsZW1lbnRh
dGlvbiBpbiB0aGUNCj4ga2VybmVsIG5lZWRzIGFjY2VzcyB0byB0aGUgcm1wdGFibGUgZm9yIHRy
YWNraW5nIHBhZ2VzIGFuZCBkZWNpZGluZw0KPiB3aGVuL2hvdyB0byBpc3N1ZSBybXB1cGRhdGUv
cHNtYXNoLiAgV2hlbiBydW5uaW5nIGFzIGEgSHlwZXItViBndWVzdA0KPiB3aXRoIFNOUCBzdXBw
b3J0LCBhbiBybXB0YWJsZSBpcyBhbGxvY2F0ZWQgYnkgdGhlIGtlcm5lbCBkdXJpbmcgYm9vdCBm
b3INCj4gdGhpcyBwdXJwb3NlLiBLZWVwIHRoZSB0YWJsZSBpbiBzeW5jIHdpdGggaXNzdWVkIHJt
cHVwZGF0ZS9wc21hc2gNCj4gaW5zdHJ1Y3Rpb25zLg0KPiANCj4gVGhlIGxvZ2ljIGZvciBob3cg
dG8gdXBkYXRlIHRoZSBybXB0YWJsZSBjb21lcyBmcm9tICJBTUQ2NCBBcmNoaXRlY3R1cmUNCj4g
UHJvZ3JhbW1lcuKAmXMgTWFudWFsLCBWb2x1bWUgMyIgd2hpY2ggZGVzY3JpYmVzIHRoZSBwc21h
c2ggYW5kIHJtcHVwZGF0ZQ0KPiBpbnN0cnVjdGlvbnMuIFRvIGVuc3VyZSBjb3JyZWN0bmVzcyBv
ZiB0aGUgU05QIGhvc3QgY29kZSwgdGhlIG1vc3QNCj4gaW1wb3J0YW50IGZpZWxkcyBhcmUgImFz
c2lnbmVkIiBhbmQgInBhZ2Ugc2l6ZSIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZXJlbWkgUGlv
dHJvd3NraSA8anBpb3Ryb3dza2lAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBhcmNo
L3g4Ni9rZXJuZWwvc2V2LmMgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zZXYuYyBiL2FyY2gveDg2L2tlcm5lbC9zZXYuYw0K
PiBpbmRleCA5NTQwNGM3ZTUxNTAuLmVkZWMxY2NiODBiMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3Nldi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXYuYw0KPiBAQCAtMjYs
NiArMjYsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvYW1kLWlvbW11Lmg+DQo+IA0KPiArI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5oPg0KDQpUaGUg
Y29kZSBpbiBzZXYuYyBzaG91bGQgYmUgZ2VuZXJpYyBhbmQgYXBwcm9wcmlhdGUgZm9yIHVzZSB3
aXRoIGFueQ0KaHlwZXJ2aXNvci4gIEFzIHN1Y2gsIEkgdGhpbmsgd2Ugd2FudCB0byBhdm9pZCBz
ZXYuYyBoYXZpbmcgYSBkZXBlbmRlbmN5DQpvbiBIeXBlci1WIHNwZWNpZmljIGNvZGUsIHN1Y2gg
YXMgdGhlIDxhc20vbXNoeXBlcnYuaD4gaW5jbHVkZSBmaWxlDQphbmQgdGhlIG1zX2h5cGVydi5u
ZXN0ZWRfZmVhdHVyZXMgdmFyaWFibGUgYXMgdXNlZCBiZWxvdy4NCg0KSW5zdGVhZCwgY3JlYXRl
IGEgYm9vbGVhbiBzdGF0aWMgdmFyaWFibGUgaW4gdGhlIHNldi5jIG1vZHVsZSBhbG9uZyB3aXRo
DQphIHdyYXBwZXIgZnVuY3Rpb24gdG8gc2V0IGl0LiAgVGhlIGxvZ2ljIHRoYXQgdGVzdHMgaHZf
bm9fcm1wX3RhYmxlKCkNCnNob3VsZCB0ZXN0IHRoaXMgc3RhdGljIHZhcmlhYmxlIGluc3RlYWQs
IHdoaWNoIHdvdWxkIGRlZmF1bHQgdG8gImZhbHNlIi4NCkh5cGVydmlzb3Itc3BlY2lmaWMgaW5p
dGlhbGl6YXRpb24gY29kZSBjYW4gY2FsbCB0aGUgd3JhcHBlciBmdW5jdGlvbg0KdG8gc2V0IHRo
ZSB2YXJpYWJsZSB0byAidHJ1ZSIgYmFzZWQgb24gd2hhdGV2ZXIgbG9naWMgaXMgYXBwcm9wcmlh
dGUgZm9yDQp0aGUgaHlwZXJ2aXNvci4gIFRoaXMgYXBwcm9hY2ggcmV2ZXJzZXMgdGhlIGRlcGVu
ZGVuY3kgYW5kIGhvcGVmdWxseQ0KaXMgdXNhYmxlIGJ5IG90aGVyIGh5cGVydmlzb3JzIHRoYXQg
d2FudCB0byBvZmZlciBuZXN0ZWQgU05QIHN1cHBvcnQuDQoNCj4gICNpbmNsdWRlIDxhc20vY3B1
X2VudHJ5X2FyZWEuaD4NCj4gICNpbmNsdWRlIDxhc20vc3RhY2t0cmFjZS5oPg0KPiAgI2luY2x1
ZGUgPGFzbS9zZXYuaD4NCj4gQEAgLTI1NjYsNiArMjU2NywxMSBAQCBpbnQgc25wX2xvb2t1cF9y
bXBlbnRyeSh1NjQgcGZuLCBpbnQgKmxldmVsKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwo
c25wX2xvb2t1cF9ybXBlbnRyeSk7DQo+IA0KPiArc3RhdGljIGJvb2wgaHZfbm9fcm1wX3RhYmxl
KHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuIG1zX2h5cGVydi5uZXN0ZWRfZmVhdHVyZXMgJiBIVl9Y
NjRfTkVTVEVEX05PX1JNUF9UQUJMRTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGJvb2wgdmlydF9z
bnBfbXNyKHZvaWQpDQo+ICB7DQo+ICAJcmV0dXJuIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9O
RVNURURfVklSVF9TTlBfTVNSKTsNCj4gQEAgLTI1ODQsNiArMjU5MCwyNiBAQCBzdGF0aWMgdTY0
IHZpcnRfcHNtYXNoKHU2NCBwYWRkcikNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0
YXRpYyB2b2lkIHNucF91cGRhdGVfcm1wdGFibGVfcHNtYXNoKHU2NCBwZm4pDQo+ICt7DQo+ICsJ
aW50IGxldmVsOw0KPiArCXN0cnVjdCBybXBlbnRyeSAqZW50cnkgPSBfX3NucF9sb29rdXBfcm1w
ZW50cnkocGZuLCAmbGV2ZWwpOw0KPiArDQo+ICsJaWYgKFdBUk5fT04oSVNfRVJSX09SX05VTEwo
ZW50cnkpKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKGxldmVsID09IFBHX0xFVkVMXzJN
KSB7DQo+ICsJCWludCBpOw0KPiArDQo+ICsJCWVudHJ5LT5pbmZvLnBhZ2VzaXplID0gUk1QX1BH
X1NJWkVfNEs7DQo+ICsJCWZvciAoaSA9IDE7IGkgPCBQVFJTX1BFUl9QTUQ7IGkrKykgew0KPiAr
CQkJc3RydWN0IHJtcGVudHJ5ICppdCA9ICZlbnRyeVtpXTsNCj4gKwkJCSppdCA9ICplbnRyeTsN
Cj4gKwkJCWl0LT5pbmZvLmdwYSA9IGVudHJ5LT5pbmZvLmdwYSArIGkgKiBQQUdFX1NJWkU7DQo+
ICsJCX0NCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBwc21hc2ggaXMgdXNlZCB0byBz
bWFzaCBhIDJNQiBhbGlnbmVkIHBhZ2UgaW50byA0Sw0KPiAgICogcGFnZXMgd2hpbGUgcHJlc2Vy
dmluZyB0aGUgVmFsaWRhdGVkIGJpdCBpbiB0aGUgUk1QLg0KPiBAQCAtMjYwMSw2ICsyNjI3LDgg
QEAgaW50IHBzbWFzaCh1NjQgcGZuKQ0KPiANCj4gIAlpZiAodmlydF9zbnBfbXNyKCkpIHsNCj4g
IAkJcmV0ID0gdmlydF9wc21hc2gocGFkZHIpOw0KPiArCQlpZiAoIXJldCAmJiBodl9ub19ybXBf
dGFibGUoKSkNCj4gKwkJCXNucF91cGRhdGVfcm1wdGFibGVfcHNtYXNoKHBmbik7DQo+ICAJfSBl
bHNlIHsNCj4gIAkJLyogQmludXRpbHMgdmVyc2lvbiAyLjM2IHN1cHBvcnRzIHRoZSBQU01BU0gg
bW5lbW9uaWMuICovDQo+ICAJCWFzbSB2b2xhdGlsZSgiLmJ5dGUgMHhGMywgMHgwRiwgMHgwMSwg
MHhGRiINCj4gQEAgLTI2MzgsNiArMjY2NiwzNSBAQCBzdGF0aWMgdTY0IHZpcnRfcm1wdXBkYXRl
KHVuc2lnbmVkIGxvbmcgcGFkZHIsIHN0cnVjdA0KPiBybXBfc3RhdGUgKnZhbCkNCj4gIAlyZXR1
cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHNucF91cGRhdGVfcm1wdGFibGVfcm1w
dXBkYXRlKHU2NCBwZm4sIGludCBsZXZlbCwgc3RydWN0IHJtcF9zdGF0ZSAqdmFsKQ0KPiArew0K
PiArCWludCBwcmV2X2xldmVsOw0KPiArCXN0cnVjdCBybXBlbnRyeSAqZW50cnkgPSBfX3NucF9s
b29rdXBfcm1wZW50cnkocGZuLCAmcHJldl9sZXZlbCk7DQo+ICsNCj4gKwlpZiAoV0FSTl9PTihJ
U19FUlJfT1JfTlVMTChlbnRyeSkpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAobGV2ZWwg
PiBQR19MRVZFTF80Sykgew0KPiArCQlpbnQgaTsNCj4gKwkJc3RydWN0IHJtcGVudHJ5IHRtcF9y
bXAgPSB7DQo+ICsJCQkuaW5mbyA9IHsNCj4gKwkJCQkuYXNzaWduZWQgPSB2YWwtPmFzc2lnbmVk
LA0KPiArCQkJfSwNCj4gKwkJfTsNCj4gKwkJZm9yIChpID0gMTsgaSA8IFBUUlNfUEVSX1BNRDsg
aSsrKQ0KPiArCQkJZW50cnlbaV0gPSB0bXBfcm1wOw0KPiArCX0NCj4gKwlpZiAoIXZhbC0+YXNz
aWduZWQpIHsNCj4gKwkJbWVtc2V0KGVudHJ5LCAwLCBzaXplb2YoKmVudHJ5KSk7DQo+ICsJfSBl
bHNlIHsNCj4gKwkJZW50cnktPmluZm8uYXNzaWduZWQgPSB2YWwtPmFzc2lnbmVkOw0KPiArCQll
bnRyeS0+aW5mby5wYWdlc2l6ZSA9IHZhbC0+cGFnZXNpemU7DQo+ICsJCWVudHJ5LT5pbmZvLmlt
bXV0YWJsZSA9IHZhbC0+aW1tdXRhYmxlOw0KPiArCQllbnRyeS0+aW5mby5ncGEgPSB2YWwtPmdw
YTsNCj4gKwkJZW50cnktPmluZm8uYXNpZCA9IHZhbC0+YXNpZDsNCj4gKwl9DQo+ICt9DQo+ICsN
Cj4gIHN0YXRpYyBpbnQgcm1wdXBkYXRlKHU2NCBwZm4sIHN0cnVjdCBybXBfc3RhdGUgKnZhbCkN
Cj4gIHsNCj4gIAl1bnNpZ25lZCBsb25nIHBhZGRyID0gcGZuIDw8IFBBR0VfU0hJRlQ7DQo+IEBA
IC0yNjY2LDYgKzI3MjMsOCBAQCBzdGF0aWMgaW50IHJtcHVwZGF0ZSh1NjQgcGZuLCBzdHJ1Y3Qg
cm1wX3N0YXRlICp2YWwpDQo+IA0KPiAgCWlmICh2aXJ0X3NucF9tc3IoKSkgew0KPiAgCQlyZXQg
PSB2aXJ0X3JtcHVwZGF0ZShwYWRkciwgdmFsKTsNCj4gKwkJaWYgKCFyZXQgJiYgaHZfbm9fcm1w
X3RhYmxlKCkpDQo+ICsJCQlzbnBfdXBkYXRlX3JtcHRhYmxlX3JtcHVwZGF0ZShwZm4sIGxldmVs
LCB2YWwpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCS8qIEJpbnV0aWxzIHZlcnNpb24gMi4zNiBzdXBw
b3J0cyB0aGUgUk1QVVBEQVRFIG1uZW1vbmljLiAqLw0KPiAgCQlhc20gdm9sYXRpbGUoIi5ieXRl
IDB4RjIsIDB4MEYsIDB4MDEsIDB4RkUiDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
