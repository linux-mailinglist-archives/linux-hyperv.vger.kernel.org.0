Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7C4FE87A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Apr 2022 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiDLTPF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiDLTPE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 15:15:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB624BBAF;
        Tue, 12 Apr 2022 12:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgoPUhtlZOE9khAB4YrXhnFNhFdAlUzduTBxSsUOgkyVNZuOvfd+cOE1W+QkNJDlh/Hw/1YMQDDqmBovCHF5dLhvFm55Qi4VxDy6Ma4NH0SD3LUnx7iMyef+tNlIQpW5saXQUiTDJGZvQIn4V/wEQqXJW0k8uu6x8StGwyR+1yIWW1KeuseW0g52pvjwg3X7lLOnozIdW3vWLg1zZBMSuRsu3cCPHLijlCNSGnedZ9zO52kSRYEG/gPYKaDYaiztXviznbRmlN2/RxlF5glHTpF44V/INY+tzaZuXWe8LGlXAyucPNwSAxAJLn0a0pHp5W5lvy9GeHv+1dDOwn9Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm1ydOJucgb0M+hyATaSnr1oJYTVZIKPjQiak20SUFQ=;
 b=lGh+uvGg2A5Kf08WRksUz/pJu6/I9TZR9qKkuVcsm3DZI4WOnAYKhT6M0tY5n6zNiD7jbA98YpZNO7I67Q6ZSpTywB1Vd3NpYtaKoeNkmKWsxysEdpt2aU3tFpddK3Cd9hDzi214y3/Y9ahtKIxGFvh2tBSGFSJ0Tfm6rTwrVZfFfdJnj0vTWWEe5KnfgnQShIBbc2H4D8xQ4LOlJgJ9wSvGx+3gpLXLHrkqR58HXhcuh9W39qGZ7qpPkV0Xlm/7PpK5SJP9+SkPaWN4PbRRgL7EdvmB+1cWtrf+mn2NaniqGIhVlv4UFOPB6Ptl+KVyhzGpMQJF7yin5re4+S7FZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm1ydOJucgb0M+hyATaSnr1oJYTVZIKPjQiak20SUFQ=;
 b=jzy+Y++5LRFU70GtFcPbY7EpbVPftYLqNYVq+jL841wJfF/q28YsmQfBtMwg1uWuz/9fvv1qCvRSge0kl+w/HNWfzJzL5Fn9wjzUdSY7vXLKS8cLNw1t+yGrtiNIYpMxl3DIm3EPOhvF9BYV4BhGCMQxyou0ilZX93zxNERyn/E=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by DM6PR21MB1163.namprd21.prod.outlook.com (2603:10b6:5:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Tue, 12 Apr
 2022 19:12:42 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::31e4:d162:7b13:3cd3]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::31e4:d162:7b13:3cd3%4]) with mapi id 15.20.5186.006; Tue, 12 Apr 2022
 19:12:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix multi-MSI to allow more than one MSI vector
Thread-Topic: [PATCH] PCI: hv: Fix multi-MSI to allow more than one MSI vector
Thread-Index: AQHYTnf8DS77imUimEeFikvTjeVD3qzspRgA
Date:   Tue, 12 Apr 2022 19:12:42 +0000
Message-ID: <BYAPR21MB127006D30591602C4BEB6253BFED9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1649772991-10285-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1649772991-10285-1-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7de0c604-e936-4cbb-ae2f-ab2583c5c0c7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-12T19:10:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efe6163c-ab6e-42e6-b17a-08da1cb86b0a
x-ms-traffictypediagnostic: DM6PR21MB1163:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1163464795BD0CD5B5447AF8BFED9@DM6PR21MB1163.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfWH2DxszhVwE7oq2DXKnzcgihbbfJ04tHPTVspf4T2vohOranj9BkfMKQQF7YetrBmy/E5pkSIm6NBwvN7wfHD+06qbyxuYu18yFAj8T/oZaUGOd/QGFzUVfPN/p0ooPQ08Bhofnq+0TFUSxcJXiCCHDFi+VYKMnH2hl54RxUJwEB3i1jBjzVtjAKSJaK5cUYMi0cjwtIExUYEcGNkWvOLPau1ka/OaygzcUEvd3EWpZZegW8X+/Rh9Daet0xSPiPZXOBYbJ9llUdNHarUVaOS+MOOHKSvsWVYvzM2KoTsXFnFYtOEFSLh7jizcRoe9LKtVNKkkbzZJyJqWG1qbTGFYOgbs0Z/DsMDy55Ucz4ce2SxpON1W8ADLCl83QiKGK8MOTXCFnZA2NVNFTHN9brWoku6yElH4pxXH4y3uuWOo7/2+INJKbrqaA7pJPQPu2sJf0c4ddPDMeJQU25ddASyVZI1BcwHs5TwfCG2iw4saVr982VAepomFsYLSAIRex7VDPDrXGKT8n8HjhKVQd8Jdn1/IOHBh4bwYwRAAaYZ7UwxLwsubKye+TKF2DtiEJM4AsgNvPsfWTORqNVmRDIDckdUXb4EzrNke0O8xiGbrhvrb/x2sQ+A6O7ghjXMzJoPNVKBAYPWc2EdjMAB+FSafbtxrba7c12pSa3B2KUyb4z4xtptGGGQYEGkB8xE6FZF0UQWRA19PhNdwztNlPG9i6VhMx4AwxDu5DHepeIUk7Y/afuomkTpJf4j/pfQPN2AlBXmozsLlkMAK33QsEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(55016003)(86362001)(2906002)(10290500003)(110136005)(508600001)(316002)(33656002)(54906003)(9686003)(38100700002)(6636002)(82960400001)(6506007)(921005)(7696005)(82950400001)(5660300002)(66946007)(83380400001)(76116006)(52536014)(186003)(8676002)(66476007)(66446008)(8936002)(8990500004)(66556008)(64756008)(4326008)(122000001)(7416002)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p3o795esE58ONVk86bDoFamQj0DdLOEOkX5TzkPEfupQ9vDQcebZN0IpiZsb?=
 =?us-ascii?Q?PYmBJNYEvouAcofq3qR+ULSlOWmwFRvLAsYiaVuJs/K9T+kUk/IyMR5z8VLF?=
 =?us-ascii?Q?olWRvudGV7cxDgwAnDueTpon+j0Br/LvKRNEfXJYvIzyWs2wXQTpUwDNpU9U?=
 =?us-ascii?Q?irq0yjS2BHshevU7zLW105BgT7H8RvKWXGrh7CICP7eVQ6yqkmM2ncCWODIw?=
 =?us-ascii?Q?YV/3vgfL5pmcvL+3Ts65fcWde7PANNhKTDcMOhb0YU3KeeplXGlFq0U0qNkG?=
 =?us-ascii?Q?EiXi6sbhiOqvitPx2NK4ODrsInUT+Hmb3vghwDU7VngvgLxgeixoxuxTY+nk?=
 =?us-ascii?Q?PjIJB0bVLrNuRFSiMvnDmrMRF9d1+j5hqOpbjwGZFMKNm2gMZxYXSmqz8Ism?=
 =?us-ascii?Q?NGMnD/tT9ySa395uKDyDHjEn/eQQkxqXlZKW8tE8WB4yDYcb0v+n1hmosHy8?=
 =?us-ascii?Q?albUCrsLkm76AwFh3wvoYgICKdUKnWfK13OsDsFvJwvtNc+jFG2TL07DaEV1?=
 =?us-ascii?Q?1WaaA8fvy2kG9Ji1mcSRoOLfPPyPrCaObIemvreKUxAYnZAraWJ0pKmkbDWv?=
 =?us-ascii?Q?Lk8wnFojSG/qztiUP0Tklh18hhI+pgcsKDmZoO6jSbieYfliVgXSQVL1RQOg?=
 =?us-ascii?Q?pRQ+Idnvu24wO4UF9BfYbnQ76OE8KjX05iv56BJN51k0V1jcwupmJ1bLrjZ1?=
 =?us-ascii?Q?4WN6uKM+LHLKBE/aoPQr3VOVQUW+vwsyhHcTWIi5eHpXk2q4HcMBoO47mpAd?=
 =?us-ascii?Q?/mGFeIixp77xsv0yKc/couKlasnISwfxWHh96/lbWpqtMzX/x0znjAuh5GM5?=
 =?us-ascii?Q?9ugeBEqqKGev/PKFEGat+bZvHPYG7jxjR9YL948WVd2fLwzUDTSCm/beG+LH?=
 =?us-ascii?Q?Z9m2v7JQjYPB8c+Qn1vL95D6QWxPyKF7fKLbyozh84T3VWQ/dg6GrbQhtXZK?=
 =?us-ascii?Q?h4fziyP8hIoaXbissfebAYTBddEv2yQEaMfLoySh6Lp2ksHP6XtfHeCKqBB5?=
 =?us-ascii?Q?3B3QPJwcZGbMDLJjijDdaI1vFgDWuWFpASeMyh59f+SZaDMzcj6BHfovxaan?=
 =?us-ascii?Q?TItuYdRB01i5gBbkmyQnB1GKIBGbGgMum1iQiJzIQz2YaGXI9l0aaPkAg3Va?=
 =?us-ascii?Q?bbhL/UUYCulgBzQxSiWB20QUeEpFqrR2Xn6larIjx0aR1LtChTDDrkK45V04?=
 =?us-ascii?Q?HpYEpzUJBrGLO08yAAj31g9GNH8AXR+kjAxfHGith4jSay6ihzxrJS/S4y0M?=
 =?us-ascii?Q?QIaHXonbQGKX2jnAWloZSOl3pvYwi5VR3M9tKNjCqhlu5WNaLBAAioUD51zb?=
 =?us-ascii?Q?0nCwwz8dInkUz+NHjhXPRjlgsblh1GYBqsfsrwkU4fI5zXTxvDV0Zvi5drWC?=
 =?us-ascii?Q?ZLEaRoUs0ylBsLmLwAi/nGeZdatrs/v3jTNmim42bj6GxNwjFj2wlJ8dEzWj?=
 =?us-ascii?Q?yw+p/2zscGJ86hHOyZwKKpfLh2RM1Y5iECEPTFBSC4cyutAFHoFpB3fBPrfn?=
 =?us-ascii?Q?0IvTsO9bGQ9AhUtwC2X9O1FQkDcQ8fIC8sq2ifdyQaqWzlqlRRFQp4NIIz3Y?=
 =?us-ascii?Q?RygJc5oiSTy6hDQxtcyhou3VGFkfKWFUyd5Ra2uGMdF5K+Hb1d0nNQc6jOGf?=
 =?us-ascii?Q?ROQRc9m0tbNeYw8FZkU0FPOO2Qkfw5I9F84PFg6y9OrWpPIedR34QNQVMBuP?=
 =?us-ascii?Q?/OdMNDdmclRd245ap9DSXcCGQvmvKMMctCtvHK6C5OJxd+/S7ceQVDjlofv1?=
 =?us-ascii?Q?6eq3MYamQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe6163c-ab6e-42e6-b17a-08da1cb86b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 19:12:42.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHwewfc7HSixVHkbx7pxm8g4uWSCaFulDXCQtU/c98ZQfFzhl0MZuw8EqEaZ3KovNgbbBwgjuTwy532V4/SHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Sent: Tuesday, April 12, 2022 7:17 AM
>  ...
> If the allocation of multiple MSI vectors for multi-MSI fails in the core
> PCI framework, the framework will retry the allocation as a single MSI
> vector, assuming that meets the min_vecs specified by the requesting
> driver.
>=20
> Hyper-V advertises that multi-MSI is supported, but reuses the VECTOR
> domain to implement that for x86.  The VECTOR domain does not support
> multi-MSI, so the alloc will always fail and fallback to a single MSI
> allocation.
>=20
> In short, Hyper-V advertises a capability it does not implement.
>=20
> Hyper-V can support multi-MSI because it coordinates with the hypervisor
> to map the MSIs in the IOMMU's interrupt remapper, which is something the
> VECTOR domain does not have.  Therefore the fix is simple - copy what the
> x86 IOMMU drivers (AMD/Intel-IR) do by removing
> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS after calling the VECTOR domain's
> pci_msi_prepare().
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t
> Hyper-V VMs")
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Thanks for the fix! This looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

