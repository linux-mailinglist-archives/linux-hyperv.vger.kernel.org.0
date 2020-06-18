Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076901FFB10
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFRSbQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 14:31:16 -0400
Received: from mail-co1nam11on2112.outbound.protection.outlook.com ([40.107.220.112]:12544
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbgFRSbQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 14:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGBnew9IP0PPbH4TlwebsSY9U7aKFZGyDIJCcjHl36czSdCMwKHibOisZBXFRJ9D1Ivx9cP9QqkKANbcxJ8qZeb6UD0p46dAFPPXOV1KYyPBjA6+zhdIsv/lLBJfuoml61Rf7aWuRz7NkgCnlAYMh4bqKJYhhWWFeUkv5cP80ZPnSbNuLwX5Wmy1VO0Mz4TXfYN6SBoaMBDJUNmdJkdc2FKjL9VYVWSF0jN0yKi+I3rk6LcnLyWnvZRbInDN2713bXgsoz+axphdAaz+qF/X/np0p7NmEOYyTBe8OFtQA1V9iwXDbPSKPTWS1Vo+7XBAmn96vdL2fiEU8irtK8K7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5b2GirqCi7kFdsbb6S9a97k3CyKlUZoPNEy0J0k6pc=;
 b=K4A4r5gccF545/uhqTqvsHzgfFwwTgbCBTJywEZjhY3CJZscQ0aO31WrdTmPP+aadXys8dnumDLV6D1+6xSFAU3cxVDGVLPp+UukJhOJX3LsILsVcxU18czN9R+sN6E2Ryk3A5PEsd1vUBlIOe1nruJJtPLVH50h/AJ6YzCvxatMczVD5eg5WzlY5e0cG1U2tlqnTR44ftYJRPaCVs6ptSCk0CQw0yGlaDnJJEs0Xzxj/h26p4M4FHCvZur4vv20QB3MXlvpj8yaS18n1FuwXA1PeFMnPWag+Z66VIi9ka7bayuuH08y74QsW4iilV/oTOB5OBzLIfEKw6MGv+A8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5b2GirqCi7kFdsbb6S9a97k3CyKlUZoPNEy0J0k6pc=;
 b=hUKY9xdI5pQHYijruivpaLv2/tlLaQ9GeM5KvngJEEgE1h6GNpRqrom/4t1YME1fO8kIwo/AVXH2z0GXyspN2gj0Jqqtsi334ZPcq261UplbIaMzvdPlMakf7N/Ry8WMv2KWje1Ec/qFXG62oJK/LwGAJsfVZtxyKGm2SWWcDf0=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR21MB1781.namprd21.prod.outlook.com (2603:10b6:4:9e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.9; Thu, 18 Jun
 2020 18:31:13 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 18:31:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/8] Drivers: hv: vmbus: Use channel_mutex in
 channel_vp_mapping_show()
Thread-Topic: [PATCH 5/8] Drivers: hv: vmbus: Use channel_mutex in
 channel_vp_mapping_show()
Thread-Index: AQHWRMcQpYkZTtgfg0etCx877itD1ajes3Iw
Date:   Thu, 18 Jun 2020 18:31:13 +0000
Message-ID: <DM5PR2101MB1047A5B02F888C146E1007E4D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-6-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-6-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T18:31:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3dce1bca-44c0-4c08-8a8f-c49c30517051;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e201b54e-ddd6-456b-98ed-08d813b5c7e0
x-ms-traffictypediagnostic: DM5PR21MB1781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB17819572469B2EB0BD398AC1D79B0@DM5PR21MB1781.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpe7DYXgVvOwHrkO3QEq0fq/mNx9voSqhmsvv9RGvZzv+0P9klnWrRUwx0Ofu9pqY4WwAWZoZQTd3WlbskoX6m5bzdO6BswTwkmDHhuBxOetJB/rzVt2IAFMjiP8jgYA4vPy6yS1IX479lsjJdV5KpkUQpGDhsDXFezPI7reLW6gPEbNI0q3kZ4wXTgcptH4txL9kzv85HvxJRhxluMU0QB/fi8a2TAYIxqcZWOiS/vgqWNX0xKPqD/LahV4s1k8u1VgGn9tafW0PN16FxLclZ5omjBJA6IIBMm4Dq4ZfBl9/FbohsaL/736ArF2NZ5+69xpqcxMhYGE9b3Synjuog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(478600001)(71200400001)(4326008)(76116006)(9686003)(8676002)(66946007)(66556008)(66446008)(66476007)(82960400001)(64756008)(82950400001)(55016002)(83380400001)(8936002)(4744005)(6506007)(5660300002)(26005)(86362001)(10290500003)(52536014)(8990500004)(2906002)(33656002)(186003)(316002)(7696005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 23n0J3TDctA604Q5sOBNMBR+eJRShRY27zsbFJlTiaUK3skv5v5yOwurkRLXO2BQJATagqRehdVQg3x3gjou54RLYh+Nsxhwo8k7haBGYo77F1OApGn62sNVr2eAkGc7wh2KGzuCmX8AphIxLpO03SbYwwn7ZlVvd4vCbNaZrMt5niOryZhFKCnzLoMwaD+9tDGvP/jRBgYzt5y6DG5YB2ViOccWM81yE8FoYcIf6NRaX9iVUS1z93UXora76wrXao//YeAd0hGf/WC7PdQQjR5VSoM22OzZKn478SgXXGkSmbLf0wo1AUdTBnlOLfUDBc3iS0f1+23hf6HDejxACsd4byehhZtTDLeNYuYLuOtuNnUbDEu8id42JKOR9ubG35L+ZJHlca7HCTuR2GsdLLp3Y/bkdhkWpF1NW7VRGWRw1LBwAXFZl55S3r7lSV5T7Tgf1yEkIiY7nynQ9XWmbhfPc2PoKY5Hjm5w6mPBqwuJ/guJ7S+3S+YTd5I38xQh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e201b54e-ddd6-456b-98ed-08d813b5c7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:31:13.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZoBdXBiUMn5C3gE70Mh4FcbfVrUrJ1XB+XBMmm3VkH5Zr3KrQvqxrolJwizx2FJ7S7P00k3JH419uvOLOcGuQQMM6d3MJklYj0cftRLd+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1781
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ju=
ne 17, 2020 9:47 AM
>=20
> The primitive currently uses channel->lock to protect the loop over
> sc_list w.r.t. list additions/deletions but it doesn't protect the
> target_cpu(s) loads w.r.t. a concurrent target_cpu_store(): while the
> data races on target_cpu are hardly of any concern here, replace the
> channel->lock critical section with a channel_mutex critical section
> and extend the latter to include the loads of target_cpu; this same
> pattern is also used in hv_synic_cleanup().
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-By: Michael Kelley <mikelley@microsoft.com>
