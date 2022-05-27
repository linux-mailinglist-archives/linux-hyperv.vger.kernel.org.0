Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97175365B5
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 May 2022 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353731AbiE0QIV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 May 2022 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244397AbiE0QIU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 May 2022 12:08:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2094.outbound.protection.outlook.com [40.107.92.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2414916B;
        Fri, 27 May 2022 09:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFAYPyWBqI0NsWZNNwM8r8sfgiNrke48PaUVBzdSoIo+qjlPvW2naYaOHSvI0RwCDuyx5O1dcB1gxq7XHBGL9D/ShbfWL5IvpSAgszSeNm0CXkrs7/lR3A3vbw245ieZGtKSFneyGccMNq8SxcxTh3zP136gKPqDXsNd22nwSDXpqMrsLyRl+x/B9cpGjKerJTvtiv6Xtu37DsQl+93IXlvNzlaysGPuFwAyGqkpUuqwLh9prRAPZC1odc83W6ChJk+9htT0n0uLtLolE+5LTEfO25H+nbAfbEFqHnQxlTnAshVvN/K2VQAu88e24Qr4ahk/DbW6NHSfwTf92Z1djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkTiW6VtgFH/xIDl2GMeTOzsBRhCsUgavkqTrCRzoMI=;
 b=iHthxGlYZOmzJ/srYzU7iifMLDImiGG//egswJsrbQYNyx0x1zTxXmzudVKTJePH5DIjxjgRLrlYfXGx0eWNwZX3jlALHIaLm/JfNwvSf7VjFxjH0A+0Z3nm3SquSI8JEalEfU4/y1xVKNHoM3FIZVNHLxI1iyOJX557NOh9yM037DOsuMHva+xq0+T8Nyu2gOI0LnLP3pH/dojUKgZKnmDyv5WkxasUK3MlKV34WJ8NVh25XtsQ+8PmzkyCvOoLMqRAdfsTl7Od8HJjsd3kzcZxd0AYZVmMwgG1g0TJq+YEbUlBqAyddU2wfltQPmQGly1Aec7V/Dp206FSxJXTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkTiW6VtgFH/xIDl2GMeTOzsBRhCsUgavkqTrCRzoMI=;
 b=TxtAPqqKxFPXKUhD/HtcMLPE2FpAFMMI8lCl2YHEvz4/8sThQ1yyrL/1mpj2Wyl90HVlRhivMNBrTRwDuh9zbv2KYESkYYJYmWiowQaa4u+u4h0I8OspVLurUZ1UUm0iEIJjlSGQT78024ygO8P1AnvLD3UAxHACm+62YVKO2T8=
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com (2603:10b6:302:a::11)
 by PH7PR21MB3212.namprd21.prod.outlook.com (2603:10b6:510:1d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5; Fri, 27 May
 2022 15:41:27 +0000
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::d02a:a4e1:e2a7:beed]) by MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::d02a:a4e1:e2a7:beed%9]) with mapi id 15.20.5314.006; Fri, 27 May 2022
 15:41:26 +0000
From:   Stephen Hemminger <sthemmin@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Index: AQHYcZqCuyoQmicyPkmbcJqVfL10360y3SZQ
Date:   Fri, 27 May 2022 15:41:26 +0000
Message-ID: <MW2PR2101MB10354159598C83FF6EF6777ACCD89@MW2PR2101MB1035.namprd21.prod.outlook.com>
References: <1653636136-19643-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653636136-19643-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d727467-68ff-48b3-81de-b31cda484a30;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-27T15:41:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14b52e83-50bf-4eb6-df15-08da3ff75c6e
x-ms-traffictypediagnostic: PH7PR21MB3212:EE_
x-microsoft-antispam-prvs: <PH7PR21MB32124C303A8FEC08258B0E9ACCD89@PH7PR21MB3212.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YFMxx+4VqPMbLUk4/Q83ceoyoFc8J6IobgR+5UIei7O/fmoiczmT/zwk47xO2zYLraxoyfu3nJVTJCOSeCJo18Ret0lvMVr8lfR56J3VPEIYOSOVNGwKbnoliumFoLygTr26ibVykras8TgkK+RD3WTtfc9JGWz1jN32EDhEbBKlFJXlHfEsY82PQ+oXmQL9hTVUA0ikBCkDT+KaVSGHJPNuFn5H9Fd8kTpfE4WjlAMZjaWRFG39WSmCzAEj7Xqg1RiHZb8WauLf52FgqQGeGqzqU5pdHe7yO2XIIbgi42vwTyUbl5FB8u3KIJqjKPApkednymheO1SarunqyvQhnySUMAE6UUB2DBLeld0eXwtV8CaNoF6gySC7ACbQcb4pb9VBSaqWiDOCvyoq7C22EWFdLhhMznZAu+zgJ20/GzRTkue5Ms+ymECmyaha4Sd7EG2V9Di0v0LaKSmam8jEaculhCHqGgHNlpN/Ylet805qbny7QFoShLbkxuzA7imWBSSJdqCnquDoh3GDOrSDd+ouJE7Y1gjgQ/oRv5ykJ2wXZA277FCTK8WUWgbGFAJuACuF779JSqoms+VqJGvOuY4EXRPVVp4dZ5Ag5/x4dEgT1vVX0NymSpIyBVEuKZYDI1iOlcbZ8C2JXkBiPjRhA1dxoAkLFqGi5z1Q2GJq5BwcsVgjJB4VcW8v/MsD6l6vLbLreeKgZ76d4L2q5H0ecGeuxxEU0A7WHH/n7ZxFmLuFshJZ1BLpo8xYEcuCGiY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1035.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(7696005)(8990500004)(2906002)(53546011)(6506007)(33656002)(26005)(9686003)(508600001)(52536014)(186003)(5660300002)(8936002)(86362001)(83380400001)(38100700002)(38070700005)(10290500003)(316002)(6636002)(82950400001)(82960400001)(66556008)(66946007)(66476007)(76116006)(110136005)(122000001)(66446008)(55016003)(8676002)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDk3QWVyRXZHaTBpVTJQU1lyb2E0TEIzdldFQU96ck9tamNKdE5uV2FVcnBn?=
 =?utf-8?B?dHNiOW9pSnEwZXg4S2hYa2JhQm5pQnduUnJ3NEJsL01BQUpZTWdHZ0UrdnVq?=
 =?utf-8?B?TFlwYXovNUdNekxHcWlrTmFjV3JxVWp4blFrb25pZk0wM0Q2Qy9JWkMyLzNS?=
 =?utf-8?B?dk5sdHVGS0tvbnN5RE1JL2NJSzllWjV2TWJ6R2J0TmF5SjRqN1hkSy85QXVp?=
 =?utf-8?B?bENxWkc1KzVWR0dVb281NXpTRFlHV0RSZ1k2MVRBbVYrbU5kZSt4MWpNaWNY?=
 =?utf-8?B?emc3VWFHYURuREtYa0lLbUdMUTlPM2JPcXU0Ty82MExVWkZmTDV0ajJ2TlZk?=
 =?utf-8?B?bldMTGNFMUtSNU9Na3FXaEYrQVV3anBhTitYUTlGWnNiWjBjY1hBRWNOMnlD?=
 =?utf-8?B?NUh6bFVKTThJSTdWVTRZT05iTGZPdGpVZ2JGVXZYcU9RU2xlS2hnWFNXcXMy?=
 =?utf-8?B?TTRmYjl4V3l1RUQ5aGZZRFQzVXdUY3lycG5GRzVDVFZqMG5YU21tQUZCaU1x?=
 =?utf-8?B?anlhcjBvV2ZpVUd2NXA1SUpnaGdFazBabUhxZWlTZzltSlYvK3hPRkd5czlG?=
 =?utf-8?B?b0pZYUVTcG9iUllYNnRJNG1sYzVZM0ZiWFY1cyttTGhNSEtCd0hXUWFjbUhJ?=
 =?utf-8?B?a0FWV0xxQ1JRNHB1Tmhqc3JhbmNXdEJQQlhVUkgxKzBqdDVFSFJzUysxZU9k?=
 =?utf-8?B?cElpckRoUFFlRTlUeUc1OGtBR3F2SzBzdmNnM2dBUzV3aFJyaGlqYWdudzNX?=
 =?utf-8?B?Z1BlZ0xldDk0UHMyR3NsZGxPY1NyMXJmcWpSZ3drdEQxalhsMDNNRDVzN0dZ?=
 =?utf-8?B?ZmZEMUlYeTZtKy84R05hS1kyOWx3RDVQUVFLZ21UV1ZTZUxONTkxYzNhVXJQ?=
 =?utf-8?B?SlEzZzFTS1pqaEtuamZWU2Z4a0Iwb2ZoM2dhTkRIV3pBWWtvdDVnSUcxWE8w?=
 =?utf-8?B?SzVRanpueWxUVmczemg1TmVZQWV3QzJ2QXNsSmhQeXdNMkJaY1JBMDlRY004?=
 =?utf-8?B?NGdxRE5hcXp0MGdzb1NPdkdwZWFkc1dieUF0TjdtQ3E0dUlMMUdabk9KYjZT?=
 =?utf-8?B?NWZocVA5SUhReFVZYVVVWmpSVE1lQ1VPSWRCUVJPSDQ4a3E1bERFTUp5N2pE?=
 =?utf-8?B?cHRMWWFpTlg2K3hPQXRSLyswdXNYem9LNExVYXBZL2N5U0EzUnJ0NGRaYUNH?=
 =?utf-8?B?SjJPZjhQUURzdGlBOTN1WE43T2hEQzlPVXZFZ2xpU3ZvcVBqck5Cb210Z21o?=
 =?utf-8?B?MjFMZ3piazFzZDhxYXk1VXdWcENIek1YSkhKZXBwcXBxeU1rRVNaWDdJckNr?=
 =?utf-8?B?ck1EWDZvcjlUUHRMSnpNc3ZHS2d6SEw4SlI5R00zMElRbVFZRXI3d0tKbm14?=
 =?utf-8?B?RGZLL0kxVHFhdEQxYWNVeXQzSVo5UmQyNmhPZEZvSzJNbUJQOVlnenJLamlT?=
 =?utf-8?B?elpJSGVPemNpalVZeGlpTm5hdHF5anlsSUpjakpocjFtQkVBaGJMYk1RK1kv?=
 =?utf-8?B?ZUR4NmFidVZaRDR6VzliazZIL1AwdDdoWHFVZzZZUi91OFE0QlIvaFRTamNT?=
 =?utf-8?B?Y012WXB2dm0reWgvL0R6R21KSE8vSXlZTHVYNVBickNqNitKRXQrUUNTMjlF?=
 =?utf-8?B?OGhrM0VLQmU4ZkdjSGVCT1ExNWRUS3JMR045MEFncGtWSjRJUHpPcGtuc2xV?=
 =?utf-8?B?OHpFOW85TVJtY3ZKcEM3Rk8vWU1OdzFxV2dNWDBzMG9WZHE0U25PalY4RUd4?=
 =?utf-8?B?UnFRZXV0bkpxVUR2TGw4VXdYS2taN2MvZDJvVTZDZDAra2lTYmY3dUZuM1ll?=
 =?utf-8?B?VHE0WlI5elc2YUlBTWZDNFJVSSsyNXFjUHpCRWZoVmk0WnNiYzFsd05wQ2ZV?=
 =?utf-8?B?RDQ0RUdDQ01Vc1VlZVVRaHpveS8wMzVHU0ExTUc0Y1NHUXdsakZ0TlRhejhL?=
 =?utf-8?B?a3J6cWFRQVlLcjRzOUl1Vi9ESlZDaDdZcWRKYk81RHphcEZJTkJUbVhCdE1D?=
 =?utf-8?B?dWRkMk1QNDcxdzR5QlpuM1IrZ2JCOElsa2hIaFhNZVpxbTc1ajdPRS9JL0FD?=
 =?utf-8?B?UGRTVG1BcXJJU0dEQTNOdUl0aGpweVVZUy9CYmI2TTllR1E2SW9mNHhvMWhT?=
 =?utf-8?B?ZEVSRGZmSzVacTVXNVozZzBuSnNCaGdYTERkbmp1OXNtRyt1TGJyNnZQVFhy?=
 =?utf-8?B?RHRLOVY3RTlZL0dEMHVrRkt1TmRUS21HakQ2VE5WTkhUVTZNZktmM0tacldK?=
 =?utf-8?B?bDNYTWgwNnJ4bE9NM1Y3ckRzbk9od0V2VUxmWVNTT29WRE1QVmx6SVJwR1hC?=
 =?utf-8?B?VkM4RStnSnczbnBBZUZ6ZTZmWUtlRDEwb0JaSzFHU0FtK1FjdDI5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1035.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b52e83-50bf-4eb6-df15-08da3ff75c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 15:41:26.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FTLrUSWuvzhPxvN01eSXTqNOtSI54kzROg65Zbw+2mxA9wsq7H0mm4hs4Cy/N90Cqj+fa1sRmNEOG8InWlPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3212
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

V291bGQgdGhpcyBoYXZlIGltcGFjdCBmb3IgRFBESyBhcHBsaWNhdGlvbnMgdXNpbmcgaXNvbGF0
ZWQgY3B1cz8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNhdXJhYmggU2Vu
Z2FyIDxzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb20+IA0KU2VudDogRnJpZGF5LCBNYXkgMjcs
IDIwMjIgMTI6MjIgQU0NClRvOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhh
aXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlciA8
c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aSA8
ZGVjdWlAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNhdXJhYmggU2luZ2ggU2VuZ2FyIDxzc2VuZ2FyQG1p
Y3Jvc29mdC5jb20+OyBNaWNoYWVsIEtlbGxleSAoTElOVVgpIDxtaWtlbGxleUBtaWNyb3NvZnQu
Y29tPg0KU3ViamVjdDogW1BBVENIIHYyXSBEcml2ZXJzOiBodjogdm1idXM6IERvbid0IGFzc2ln
biBWTWJ1cyBjaGFubmVsIGludGVycnVwdHMgdG8gaXNvbGF0ZWQgQ1BVcw0KDQpXaGVuIGluaXRp
YWxseSBhc3NpZ25pbmcgYSBWTWJ1cyBjaGFubmVsIGludGVycnVwdCB0byBhIENQVSwgZG9u4oCZ
dCBjaG9vc2UNCmEgbWFuYWdlZCBJUlEgaXNvbGF0ZWQgQ1BVIChhcyBzcGVjaWZpZWQgb24gdGhl
IGtlcm5lbCBib290IGxpbmUgd2l0aA0KcGFyYW1ldGVyICdpc29sY3B1cz1tYW5hZ2VkX2lycSw8
I2NwdT4nKS4gQWxzbywgd2hlbiB1c2luZyBzeXNmcyB0byBjaGFuZ2UNCnRoZSBDUFUgdGhhdCBh
IFZNYnVzIGNoYW5uZWwgd2lsbCBpbnRlcnJ1cHQsIGRvbid0IGFsbG93IGNoYW5naW5nIHRvIGEN
Cm1hbmFnZWQgSVJRIGlzb2xhdGVkIENQVS4NCg0KU2lnbmVkLW9mZi1ieTogU2F1cmFiaCBTZW5n
YXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4NCi0tLQ0KdjI6ICogYmV0dGVyIGNvbW1p
dCBtZXNzYWdlDQogICAgKiBBZGRlZCBiYWNrIGVtcHR5IGxpbmUsIHJlbW92ZWQgYnkgbWlzdGFr
ZQ0KICAgICogUmVtb3ZlZCBlcnJvciBwcmludCBmb3Igc3lzZnMgZXJyb3INCg0KIGRyaXZlcnMv
aHYvY2hhbm5lbF9tZ210LmMgfCAxOCArKysrKysrKysrKystLS0tLS0NCiBkcml2ZXJzL2h2L3Zt
YnVzX2Rydi5jICAgIHwgIDQgKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hhbm5lbF9tZ210
LmMgYi9kcml2ZXJzL2h2L2NoYW5uZWxfbWdtdC5jDQppbmRleCA5N2Q4ZjU2Li5lMWZlMDI5IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9odi9jaGFubmVsX21nbXQuYw0KKysrIGIvZHJpdmVycy9odi9j
aGFubmVsX21nbXQuYw0KQEAgLTIxLDYgKzIxLDcgQEANCiAjaW5jbHVkZSA8bGludXgvY3B1Lmg+
DQogI2luY2x1ZGUgPGxpbnV4L2h5cGVydi5oPg0KICNpbmNsdWRlIDxhc20vbXNoeXBlcnYuaD4N
CisjaW5jbHVkZSA8bGludXgvc2NoZWQvaXNvbGF0aW9uLmg+DQogDQogI2luY2x1ZGUgImh5cGVy
dl92bWJ1cy5oIg0KIA0KQEAgLTcyOCwxNiArNzI5LDIwIEBAIHN0YXRpYyB2b2lkIGluaXRfdnBf
aW5kZXgoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwpDQogCXUzMiBpLCBuY3B1ID0gbnVt
X29ubGluZV9jcHVzKCk7DQogCWNwdW1hc2tfdmFyX3QgYXZhaWxhYmxlX21hc2s7DQogCXN0cnVj
dCBjcHVtYXNrICphbGxvY2F0ZWRfbWFzazsNCisJY29uc3Qgc3RydWN0IGNwdW1hc2sgKmhrX21h
c2sgPSBob3VzZWtlZXBpbmdfY3B1bWFzayhIS19UWVBFX01BTkFHRURfSVJRKTsNCiAJdTMyIHRh
cmdldF9jcHU7DQogCWludCBudW1hX25vZGU7DQogDQogCWlmICghcGVyZl9jaG4gfHwNCi0JICAg
ICFhbGxvY19jcHVtYXNrX3ZhcigmYXZhaWxhYmxlX21hc2ssIEdGUF9LRVJORUwpKSB7DQorCSAg
ICAhYWxsb2NfY3B1bWFza192YXIoJmF2YWlsYWJsZV9tYXNrLCBHRlBfS0VSTkVMKSB8fA0KKwkg
ICAgY3B1bWFza19lbXB0eShoa19tYXNrKSkgew0KIAkJLyoNCiAJCSAqIElmIHRoZSBjaGFubmVs
IGlzIG5vdCBhIHBlcmZvcm1hbmNlIGNyaXRpY2FsDQogCQkgKiBjaGFubmVsLCBiaW5kIGl0IHRv
IFZNQlVTX0NPTk5FQ1RfQ1BVLg0KIAkJICogSW4gY2FzZSBhbGxvY19jcHVtYXNrX3ZhcigpIGZh
aWxzLCBiaW5kIGl0IHRvDQogCQkgKiBWTUJVU19DT05ORUNUX0NQVS4NCisJCSAqIElmIGFsbCB0
aGUgY3B1cyBhcmUgaXNvbGF0ZWQsIGJpbmQgaXQgdG8NCisJCSAqIFZNQlVTX0NPTk5FQ1RfQ1BV
Lg0KIAkJICovDQogCQljaGFubmVsLT50YXJnZXRfY3B1ID0gVk1CVVNfQ09OTkVDVF9DUFU7DQog
CQlpZiAocGVyZl9jaG4pDQpAQCAtNzU4LDE3ICs3NjMsMTkgQEAgc3RhdGljIHZvaWQgaW5pdF92
cF9pbmRleChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCkNCiAJCX0NCiAJCWFsbG9jYXRl
ZF9tYXNrID0gJmh2X2NvbnRleHQuaHZfbnVtYV9tYXBbbnVtYV9ub2RlXTsNCiANCi0JCWlmIChj
cHVtYXNrX2VxdWFsKGFsbG9jYXRlZF9tYXNrLCBjcHVtYXNrX29mX25vZGUobnVtYV9ub2RlKSkp
IHsNCityZXRyeToNCisJCWNwdW1hc2tfeG9yKGF2YWlsYWJsZV9tYXNrLCBhbGxvY2F0ZWRfbWFz
aywgY3B1bWFza19vZl9ub2RlKG51bWFfbm9kZSkpOw0KKwkJY3B1bWFza19hbmQoYXZhaWxhYmxl
X21hc2ssIGF2YWlsYWJsZV9tYXNrLCBoa19tYXNrKTsNCisNCisJCWlmIChjcHVtYXNrX2VtcHR5
KGF2YWlsYWJsZV9tYXNrKSkgew0KIAkJCS8qDQogCQkJICogV2UgaGF2ZSBjeWNsZWQgdGhyb3Vn
aCBhbGwgdGhlIENQVXMgaW4gdGhlIG5vZGU7DQogCQkJICogcmVzZXQgdGhlIGFsbG9jYXRlZCBt
YXAuDQogCQkJICovDQogCQkJY3B1bWFza19jbGVhcihhbGxvY2F0ZWRfbWFzayk7DQorCQkJZ290
byByZXRyeTsNCiAJCX0NCiANCi0JCWNwdW1hc2tfeG9yKGF2YWlsYWJsZV9tYXNrLCBhbGxvY2F0
ZWRfbWFzaywNCi0JCQkgICAgY3B1bWFza19vZl9ub2RlKG51bWFfbm9kZSkpOw0KLQ0KIAkJdGFy
Z2V0X2NwdSA9IGNwdW1hc2tfZmlyc3QoYXZhaWxhYmxlX21hc2spOw0KIAkJY3B1bWFza19zZXRf
Y3B1KHRhcmdldF9jcHUsIGFsbG9jYXRlZF9tYXNrKTsNCiANCkBAIC03NzgsNyArNzg1LDYgQEAg
c3RhdGljIHZvaWQgaW5pdF92cF9pbmRleChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCkN
CiAJfQ0KIA0KIAljaGFubmVsLT50YXJnZXRfY3B1ID0gdGFyZ2V0X2NwdTsNCi0NCiAJZnJlZV9j
cHVtYXNrX3ZhcihhdmFpbGFibGVfbWFzayk7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQppbmRleCA3MTRkNTQ5Li41
NDdhZTMzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KKysrIGIvZHJpdmVy
cy9odi92bWJ1c19kcnYuYw0KQEAgLTIxLDYgKzIxLDcgQEANCiAjaW5jbHVkZSA8bGludXgva2Vy
bmVsX3N0YXQuaD4NCiAjaW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5oPg0KICNpbmNsdWRlIDxs
aW51eC9jcHUuaD4NCisjaW5jbHVkZSA8bGludXgvc2NoZWQvaXNvbGF0aW9uLmg+DQogI2luY2x1
ZGUgPGxpbnV4L3NjaGVkL3Rhc2tfc3RhY2suaD4NCiANCiAjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4NCkBAIC0xNzcwLDYgKzE3NzEsOSBAQCBzdGF0aWMgc3NpemVfdCB0YXJnZXRfY3B1X3N0b3Jl
KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsLA0KIAlpZiAodGFyZ2V0X2NwdSA+PSBucl9j
cHVtYXNrX2JpdHMpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCisJaWYgKCFjcHVtYXNrX3Rlc3Rf
Y3B1KHRhcmdldF9jcHUsIGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfTUFOQUdFRF9JUlEp
KSkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KIAkvKiBObyBDUFVzIHNob3VsZCBjb21lIHVwIG9y
IGRvd24gZHVyaW5nIHRoaXMuICovDQogCWNwdXNfcmVhZF9sb2NrKCk7DQogDQotLSANCjEuOC4z
LjENCg0K
