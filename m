Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBA33D76B
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Mar 2021 16:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhCPPaG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Mar 2021 11:30:06 -0400
Received: from mail-eopbgr770119.outbound.protection.outlook.com ([40.107.77.119]:39028
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236769AbhCPP3k (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Mar 2021 11:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqvTptw3sskEXpAfEuWTWpv6FGJVgk3PtbWmv0N/P0ODey7HBk4TQ9ENXbPMpsHQyudKKOXE4yRwOzQJclJtnPKhYzKvUGOtccx/Eb/URIhjP+fw86UuQdt1pI/7gE7FaRk+Z+5IZ0Dhng++g2ukmv07DouY9ciV78kExE2B4rXZrFdL7eBt80qRyWLNnjX64UZ4UvsqN8dwdlFR0JsRvcSnVA6OKvTkBGjF5LfOh3YC0OeAAw8RW7AmToWPqsbF14YUw5qDF5HBScnl6TfP+9tmDzVoZPabF+N0DUG1ry+McADd2Igcvqyrpi2EhfyymVbTNSoyEKcov0IQPGaF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/5G/8NOFoP4cr1URKHxPVYCHX07pk4ADDykvFlDw+U=;
 b=iXLfu4L60eYVvYqwGnWqmyuqJw38moQUiFf3LdNPHmDTiHY+3zk3p8CA+2hq3vi7uclUaoP2c0sjUi5f0Ltd29vc1xceFKutUSxAhzXOEj/SE1q9tUmWAMbWM35vu74euL9TJ1XiORiGC3y7pNKvFB2dnDeYp2eKc8yrs4AV6cw/5AVA4w6V6ZhUifWgFmy4L9sn6ZgmWCslFMYslX/FrSCXtofHP9PfHVyy2sGPZQ1viM7V5ZE1NOWjnEF5Ae862+SsYGX/wbOMtrB/Wfsb6Opvx77h0+pj4FQ43dbWjzvENp9tiZklR1L9x8YHHMhdEctmS/oh2n0WSZpnwbAauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/5G/8NOFoP4cr1URKHxPVYCHX07pk4ADDykvFlDw+U=;
 b=CBkztz5QUBQ2b2jpz8Brk8ZphqIPBWXpcle+R4cn7Kc4YGcsmk9If7lzQ4uGyvLM60yCzlvlaEz3+fBu6laknnr412ZuwTBQMPa9Eqrfw2SxeOZxKsFNtfn9Pl+v0POM9Ai1OE27EnOrEnfUnu+FYVjMoDceuIZDTU4LXH5mMBE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.5; Tue, 16 Mar
 2021 15:29:35 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3977.004; Tue, 16 Mar 2021
 15:29:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     KY Srinivasan <kys@microsoft.com>, Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v2 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Topic: [PATCH v2 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Index: AQHXCjWQrk6zOFapVE6P9gyPvlFjIapyBSUAgBTYbxA=
Date:   Tue, 16 Mar 2021 15:29:35 +0000
Message-ID: <MWHPR21MB1593E5D7A0577A0BA2499CD9D76B9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614120294-1930-1-git-send-email-mikelley@microsoft.com>
 <87mtvkeh9r.fsf@vitty.brq.redhat.com>
In-Reply-To: <87mtvkeh9r.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-16T15:29:33Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6525b8a6-eff6-42ce-8a04-22c5546a359c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fafa503-3436-4591-992d-08d8e8904e1e
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19561F098D7D7B5FD747A4ECD76B9@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quKzQzwjCCdnbCd0v5a/hwSBD4T7gyGqDS9qUCq0mkZACT4Rf/chVVIw2/Ah8jjgPtUqo3jeTRJOG/qeBIczaRm4IFUm804X8+YghGWhRbE+4f7yo47v2V57gSRZrCEtKUV1dOKw83mrK1UhBr0CcNswXbBzSsncmnBOJ/K4N8DUUV32+uPgAyzrdPtOTXCYdbFUO4cVjpxubHqUgEeY+ccRSWJ3/AY/JGrFGBuQ8zowjlYpqngmPpJT8FSPlc+JeRZGXoN9Ne8SGKebsxDDueEwfNc/cU5/6/BVm0UwQ+GUs0PVJH4bnUmYpFqo1XFFnGYATMW7U3bsopjvOhxIKeWQvk+fhWvxCo5tkQW6CgHp9Nsalljg54LJ84TAjVxH31sRv6A/hjzM2MWj0MEd7aWNhkmJT7xM76b3K7CskHQ4nK+kkTZ5I8oKM22CkLdSR16dhjhUzdPNsTJAgXQgooIZ6FdPwYTOjbpb6dItcKdl3h8mRHXGdbwFt3DAdMSxU4S9cm4lGlzrmPfd/pPqFIvM7X5+gGQAfHyZ/zeENKrAPF0/JPD9touJeP1fSuff
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(64756008)(82950400001)(26005)(66446008)(76116006)(478600001)(66556008)(82960400001)(316002)(66946007)(8990500004)(54906003)(55016002)(2906002)(9686003)(10290500003)(6916009)(7696005)(6506007)(83380400001)(5660300002)(53546011)(4326008)(71200400001)(186003)(66476007)(33656002)(8936002)(8676002)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jl2lOfSKlzT2S9b3FDIA9i5VzaYaCC7K6kbcbmoDy9kogpbKXzVYSNELWEmb?=
 =?us-ascii?Q?osH0y3GAiia7aNydn8sZ+keYRcMuS2kc7dqpSn/RTwxDQ3/GCQcyjKA1HBDU?=
 =?us-ascii?Q?BZtFJmH3xF13/XhqtQUTFyKM7hqlBfTAWQzbL1y6DRMJuUomY982GqZOI26l?=
 =?us-ascii?Q?87564SOISe2zN9+fXEt1uvzK5+t4E3E0vZPs/kV9GCaD4fDpVSY0WdcCbShV?=
 =?us-ascii?Q?TTe48n4nYipKQzGt0v9CQXyhJWyWs3BqnjI/nXhBmkOotX9DUwmHDUabRb+X?=
 =?us-ascii?Q?BzFLY9JLTRNOMfVi8O9AD+Rc8n3b/RX7OKvrUMUiLlBjs3KfEwlQTTYrTjJ5?=
 =?us-ascii?Q?SfWCDL1Y8SxsG+uetXoT+WAF39Nu4YSF+qExme9LSqrLIzulB/ZqXCXLj/+g?=
 =?us-ascii?Q?jwy8ST0OTqkoK1y7Qsj3QFhv4NRFW6fwEW5EqRV9qYYnGSbnIZpCM7bBgNGF?=
 =?us-ascii?Q?1iMQiG2AshBup4VTyEiJec1Ez+rLUDEhhgi1sO4WjpHx4O3hNbg58zXZnE4K?=
 =?us-ascii?Q?Lu0xw1Ia1ZR9Mocd6tl64ezJIHoSzsr708XO4m6BzF3Mp2y4SQiatmBu8nHz?=
 =?us-ascii?Q?9rDGg28qF3R6qbfsDioHYgUXO+H1FR70v1VWMu5qkJ6DW3/KwCGFHtvdH9oC?=
 =?us-ascii?Q?k76c433Vmmx821djtouhqEJu2GNskR1qQijAoGa2OMpk1nPVjPN71xHL8Um5?=
 =?us-ascii?Q?lQ9OnoJKXamq7FY+MzvTN7rJRqt4DMCLZp/JWmIxXavyA7986sPa58JZtWc4?=
 =?us-ascii?Q?+CBY2fv1ko3jvVEmim1i1CM/AZCNDfw1LpXAZ0PmbQrnkP23CcMhqklxARlD?=
 =?us-ascii?Q?XN9iysXbH3LqE4CHJq7vUYgw+V9lbzZiaAMHkABZYUMiTcka9bmrSY0nZARm?=
 =?us-ascii?Q?yBe7MDbIllwyMoVp46aCLDB1oWrNhx65lay2D8CDlxUiWOucY2qcgQ40max/?=
 =?us-ascii?Q?9ZeFYev/hRVGpVSBrvXuwqPIrv7xAdinHamPpeGJAKe1UfyyWvlNLXJXPAAs?=
 =?us-ascii?Q?XG7aw7T8YzQmai6OZwShtwR8LEcRcEVt9xdihz/XPBPjhjg9y/SDfr4Qwr9N?=
 =?us-ascii?Q?aw3ueGXQg5ve340JxArfwRUAPtmAf2POiM6oYtaDP7fHEK9fwHGyL2tRzhKT?=
 =?us-ascii?Q?phYbC14B3MrSLORDX5E2AnLH3+sQYyq/+gkIQP+2TUWq2W5nFEeZdsIOjpPF?=
 =?us-ascii?Q?e31QGIA8Cc//fdvc3vyX7hk3E13AlB+nTiceqvbcxs6Fmc6wTE5My6vsJkGj?=
 =?us-ascii?Q?AUciysSIoqEj4FdxNyA6wuGPN7Eyk4oVNu78HObEI/7wQwy7eZ5wxCuoszCd?=
 =?us-ascii?Q?aBbHp8bqIy1udjgOZZAdgoWc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fafa503-3436-4591-992d-08d8e8904e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:29:35.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0zFlQrJVXDb7GMbFMDc80UHBzIuaByXdJKET22L6DK5SqeVTIwLk/cOS1g9hvhHge36ikKSW25XeSUH5pZdaojyHV0SgApaRwOhiRhkTSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, March 3, 2021=
 1:09 AM
> To: Michael Kelley <mikelley@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; martin.petersen@oracle.com; Long L=
i
> <longli@microsoft.com>; wei.liu@kernel.org; jejb@linux.ibm.com; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; linux-scsi@vger.ker=
nel.org
> Subject: Re: [PATCH v2 1/1] scsi: storvsc: Enable scatterlist entry lengt=
hs > 4Kbytes
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> > storvsc currently sets .dma_boundary to limit scatterlist entries
> > to 4 Kbytes, which is less efficient with huge pages that offer
> > large chunks of contiguous physical memory. Improve the algorithm
> > for creating the Hyper-V guest physical address PFN array so
> > that scatterlist entries with lengths > 4Kbytes are handled.
> > As a result, remove the .dma_boundary setting.
> >
> > The improved algorithm also adds support for scatterlist
> > entries with offsets >=3D 4Kbytes, which is supported by many
> > other SCSI low-level drivers.  And it retains support for
> > architectures where possibly PAGE_SIZE !=3D HV_HYP_PAGE_SIZE
> > (such as ARM64).
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >
> > Changes in v2:
> > * Add HVPFN_DOWN() macro and use it instead of open coding
> >   [Vitaly Kuznetsov]
> > * Change loop that fills pfn array and its initialization
> >   [Vitaly Kuznetsov]
> > * Use offset_in_hvpage() instead of open coding
> >
> >
> >  drivers/scsi/storvsc_drv.c | 66 ++++++++++++++++----------------------=
--------
> >  include/linux/hyperv.h     |  1 +
> >  2 files changed, 24 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 2e4fa77..5ba3145 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1678,9 +1678,8 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct
> scsi_cmnd *scmnd)
> >  	struct storvsc_cmd_request *cmd_request =3D scsi_cmd_priv(scmnd);
> >  	int i;
> >  	struct scatterlist *sgl;
> > -	unsigned int sg_count =3D 0;
> > +	unsigned int sg_count;
> >  	struct vmscsi_request *vm_srb;
> > -	struct scatterlist *cur_sgl;
> >  	struct vmbus_packet_mpb_array  *payload;
> >  	u32 payload_sz;
> >  	u32 length;
> > @@ -1759,8 +1758,8 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct
> scsi_cmnd *scmnd)
> >  	payload_sz =3D sizeof(cmd_request->mpb);
> >
> >  	if (sg_count) {
> > -		unsigned int hvpgoff =3D 0;
> > -		unsigned long offset_in_hvpg =3D sgl->offset & ~HV_HYP_PAGE_MASK;
> > +		unsigned int hvpgoff, hvpfns_to_add;
> > +		unsigned long offset_in_hvpg =3D offset_in_hvpage(sgl->offset);
> >  		unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + length);
> >  		u64 hvpfn;
> >
> > @@ -1773,51 +1772,34 @@ static int storvsc_queuecommand(struct Scsi_Hos=
t *host,
> struct scsi_cmnd *scmnd)
> >  				return SCSI_MLQUEUE_DEVICE_BUSY;
> >  		}
> >
> > -		/*
> > -		 * sgl is a list of PAGEs, and payload->range.pfn_array
> > -		 * expects the page number in the unit of HV_HYP_PAGE_SIZE (the
> > -		 * page size that Hyper-V uses, so here we need to divide PAGEs
> > -		 * into HV_HYP_PAGE in case that PAGE_SIZE > HV_HYP_PAGE_SIZE.
> > -		 * Besides, payload->range.offset should be the offset in one
> > -		 * HV_HYP_PAGE.
> > -		 */
> >  		payload->range.len =3D length;
> >  		payload->range.offset =3D offset_in_hvpg;
> > -		hvpgoff =3D sgl->offset >> HV_HYP_PAGE_SHIFT;
> >
> > -		cur_sgl =3D sgl;
> > -		for (i =3D 0; i < hvpg_count; i++) {
> > +
> > +		for (i =3D 0; sgl !=3D NULL; sgl =3D sg_next(sgl)) {
> >  			/*
> > -			 * 'i' is the index of hv pages in the payload and
> > -			 * 'hvpgoff' is the offset (in hv pages) of the first
> > -			 * hv page in the the first page. The relationship
> > -			 * between the sum of 'i' and 'hvpgoff' and the offset
> > -			 * (in hv pages) in a payload page ('hvpgoff_in_page')
> > -			 * is as follow:
> > -			 *
> > -			 * |------------------ PAGE -------------------|
> > -			 * |   NR_HV_HYP_PAGES_IN_PAGE hvpgs in total  |
> > -			 * |hvpg|hvpg| ...              |hvpg|... |hvpg|
> > -			 * ^         ^                                 ^                 ^
> > -			 * +-hvpgoff-+                                 +-hvpgoff_in_page-+
> > -			 *           ^                                                   |
> > -			 *           +--------------------- i ---------------------------+
> > +			 * Init values for the current sgl entry. hvpgoff
> > +			 * and hvpfns_to_add are in units of Hyper-V size
> > +			 * pages. Handling the PAGE_SIZE !=3D HV_HYP_PAGE_SIZE
> > +			 * case also handles values of sgl->offset that are
> > +			 * larger than PAGE_SIZE. Such offsets are handled
> > +			 * even on other than the first sgl entry, provided
> > +			 * they are a multiple of PAGE_SIZE.
> >  			 */
> > -			unsigned int hvpgoff_in_page =3D
> > -				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
> > +			hvpgoff =3D HVPFN_DOWN(sgl->offset);
> > +			hvpfn =3D page_to_hvpfn(sg_page(sgl)) + hvpgoff;
> > +			hvpfns_to_add =3D	HVPFN_UP(sgl->offset + sgl->length) -
> > +						hvpgoff;
> >
> >  			/*
> > -			 * Two cases that we need to fetch a page:
> > -			 * 1) i =3D=3D 0, the first step or
> > -			 * 2) hvpgoff_in_page =3D=3D 0, when we reach the boundary
> > -			 *    of a page.
> > +			 * Fill the next portion of the PFN array with
> > +			 * sequential Hyper-V PFNs for the continguous physical
> > +			 * memory described by the sgl entry. The end of the
> > +			 * last sgl should be reached at the same time that
> > +			 * the PFN array is filled.
> >  			 */
> > -			if (hvpgoff_in_page =3D=3D 0 || i =3D=3D 0) {
> > -				hvpfn =3D page_to_hvpfn(sg_page(cur_sgl));
> > -				cur_sgl =3D sg_next(cur_sgl);
> > -			}
> > -
> > -			payload->range.pfn_array[i] =3D hvpfn + hvpgoff_in_page;
> > +			while (hvpfns_to_add--)
> > +				payload->range.pfn_array[i++] =3D	hvpfn++;
> >  		}
> >  	}
> >
> > @@ -1851,8 +1833,6 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct
> scsi_cmnd *scmnd)
> >  	.slave_configure =3D	storvsc_device_configure,
> >  	.cmd_per_lun =3D		2048,
> >  	.this_id =3D		-1,
> > -	/* Make sure we dont get a sg segment crosses a page boundary */
> > -	.dma_boundary =3D		PAGE_SIZE-1,
> >  	/* Ensure there are no gaps in presented sgls */
> >  	.virt_boundary_mask =3D	PAGE_SIZE-1,
> >  	.no_write_same =3D	1,
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 5ddb479..a1eed76 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1717,6 +1717,7 @@ static inline unsigned long virt_to_hvpfn(void *a=
ddr)
> >  #define NR_HV_HYP_PAGES_IN_PAGE	(PAGE_SIZE / HV_HYP_PAGE_SIZE)
> >  #define offset_in_hvpage(ptr)	((unsigned long)(ptr) & ~HV_HYP_PAGE_MAS=
K)
> >  #define HVPFN_UP(x)	(((x) + HV_HYP_PAGE_SIZE-1) >> HV_HYP_PAGE_SHIFT)
> > +#define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
> >  #define page_to_hvpfn(page)	(page_to_pfn(page) *
> NR_HV_HYP_PAGES_IN_PAGE)
> >
> >  #endif /* _HYPERV_H */
>=20
> Thank you for implementing my suggestion in v2,
>=20
> Reviewed-by:  Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> --
> Vitaly

Martin -- Is anything else needed for you to pick up this patch?

Michael


