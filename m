Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4A32338C
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Feb 2021 23:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhBWWCA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Feb 2021 17:02:00 -0500
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com ([40.107.223.95]:10465
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230268AbhBWWB7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Feb 2021 17:01:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3XbfsIJOTsSkVC4GpZM1b7keNjKgOBD5apXGHM4byJ9Uh1RZe0INCQKb0Vqp86muh7dsJ7Z9o2OXY48Gio4gToYYmSWlOpUmXKUMEYWBPYXx51sAkaYQp75H+BEIaLNPAIr+YJSmIlHZuV09IyBYOXL79zQOTFHr3mS/XV7IjhJ1woiWh534RdeyJs2zMGOjbOF0MNFxcOBAOouRkQzDsY7j2iN8v9HV9riNBPnfp98zQXYANmIFfThBx0JpgrHOC5SvfcVeLI1bVU0XONbtk8NB7yFZZLSQwFvgoTafwM3KziHVam4Ky69KLQTWuXdBZEAWc54dwt5WXkNHV4i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9dYgqCqEBRmDKgSjOk8jU1FTnQJ30HYBdhg8N7WcZ0=;
 b=kUjrOTM4RqH9cZ7LxYpRbr2PMHHQcr0Y8wdU1OXt/Z7+1IJ6e+zUC40MH6k58SVOJ623nhX3YZ1OEOSz4sAWWrDKlCs7yOUWNbo7AA57B1b25FEpzMCtWDby2aDghjHi5BdDJh4pDHP0gqoJWkHjXN8yfpgLx5eMINbrEFOsC3upKQeSCeCplmTJKck5ssOIQnqO1vOeWKuc0VSZ64mqs0tYrA7V+cvpTwfIcsT9ccBLGtmpcuY/gaU6oF8l3DqA0zy4V+GKC0Q5PLOiuP7EYIUup/0n/xI6D1In4BQjHVq+sXhdIdO3b+0IQ9rPi+L3+U5RHeKFQsFUlaADX9OJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9dYgqCqEBRmDKgSjOk8jU1FTnQJ30HYBdhg8N7WcZ0=;
 b=CCi7Cbyi6xyN4kmNfhRuOVrWujuPrebEmLQZEXo8AcDHHE7VDqQDZewEjhXJBe2hvCzpWQg1eiXQ2NhW7WQaXPCAbYLYozUilvIFUtLB5+hPbIfFKHQs2pxztfDg6SXr1P8FSb02sMpPIOLuyxMgyoZzBINZGDpvgkr+TUOBHsY=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR21MB0183.namprd21.prod.outlook.com (2603:10b6:903:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.8; Tue, 23 Feb
 2021 22:01:10 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01%5]) with mapi id 15.20.3912.004; Tue, 23 Feb 2021
 22:01:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Topic: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Index: AQHXBjlaeseUgmW2gEGnERM19Pp+w6pl1E6AgAB9BSA=
Date:   Tue, 23 Feb 2021 22:01:09 +0000
Message-ID: <CY4PR21MB1586B18DCE13103EB554CC33D7809@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <1613682087-102535-1-git-send-email-mikelley@microsoft.com>
 <874ki2yhzm.fsf@vitty.brq.redhat.com>
In-Reply-To: <874ki2yhzm.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-23T22:01:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=36f18256-cc8a-4310-8f51-08d33846299c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0d2e573-5796-4877-dcfb-08d8d846874a
x-ms-traffictypediagnostic: CY4PR21MB0183:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB01838F6D655987FBA65A9290D7809@CY4PR21MB0183.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYMbCblNrDMeLn21ylTzp7FQkPPd/qj1tsvOR30KybNCv/aEnaG951LK+C/5B4xVUB0l0M5nGcIGlqcd+kZLXNh/U7/98eFpH1fPCX/oe9waen3U8GKf7/8BrztIo+9g85caX4zcao7yfaiAudeyoR8OeVCp+U4FH+JOu2L0N5G1X5blKfz9phqVbhwYSIEeVu0K6Kvw8Mm0YHMRK4zxetUAIjWtTHorOnRySuz4vSF5B5y95kyMlpFuPJt+4V4WviTAdIk70cvjyzGriWRo8+V1HVmUk3KTHDoRxRvy0WFU/W6vZoIBEdHgYAAAl7evhrNP81R8XlSro7U1QWL82HNPVuDpYLLy3lzQ8jCSbA/PzwBomS+69A1V8shZ8ugaRvKIDVuiZya67YYoPKe3rKE0vYu5nlJXys7RjHsDyNDoWO94J4IwoPKHKZ4QX88I2lEcCA8/nFbHMVLMN9HNxioe7VjjdkcAD4GdO40F+tOYDcUhRu78Ikg0tJ65Zzg9YLEAvj23Ojlp+t4T1KWTWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(7696005)(82960400001)(82950400001)(52536014)(55016002)(9686003)(2906002)(83380400001)(66476007)(66446008)(76116006)(66556008)(33656002)(26005)(64756008)(66946007)(86362001)(186003)(4326008)(8676002)(71200400001)(8936002)(6916009)(5660300002)(6506007)(316002)(54906003)(478600001)(10290500003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fyI13Zo14nRR1HxAXrp33pDhuMPcyrNNG0FPwoTcOR8YPt7paDS3AeYtBKyA?=
 =?us-ascii?Q?J3JG6bt0kCgVgZlCnIXA7GkaTWNE7umNJRu0spCkdViP7tCE4nlijr9yciIM?=
 =?us-ascii?Q?0KBV7TmyU466H7LBTkvLK9Dzt+7C+EIsqnLypzgmh9kqZ8I/O2hAmuvQ/H4r?=
 =?us-ascii?Q?qjEN3YSmybpm9xCGGqFwy7PTjtl+q1P9WIBQcutdc6g9JZL3xIn3fjzyCJdM?=
 =?us-ascii?Q?31XxTd6PqXPHyf3ByvG/dODKQ2adJ6U6edZERVlf3kMTvoTdbXpXhDxgdzC5?=
 =?us-ascii?Q?nGy/MIPyMLK0tX4kFf3jHjEx65N16Fgr1+8bPDFM84vGB9xQJk7vCB6lo7ni?=
 =?us-ascii?Q?Iy/RKDckJla5WdbEPnj2tze2UzTBlvVARQNzG9d14AeRYYnyttcCcfwbQcTS?=
 =?us-ascii?Q?8huZgMp0Kkv2jCGYdNlJy2kp7TelW51Nu77972ZTKfJSmrtL+VAtzf+REjwu?=
 =?us-ascii?Q?N0sb0Dm1IS/iWgG+zp1BfNmGGrlD0qmsrfSOHu02YHLghoA3dVrSUp4j5Mpc?=
 =?us-ascii?Q?Sk7168P0dXFRsV1nyx/7OSTt29axeoeTIrg5mqlsiSrf0Fx8m2w+CSphOcy7?=
 =?us-ascii?Q?bne/bFb8iA6JfhrLOtTe/bQOAbJ+CeU508vMKc9XovlZ4oi4VMBEJeXH8sP9?=
 =?us-ascii?Q?Lms0lQ/Qb/NArfgJKciSsYwTsVRn76IcE0W+6NKph/kshHSAxF9omIo2+nzj?=
 =?us-ascii?Q?o3QVxQ/vSzdqJaZvgkF54LaRijw8vNgcq9FymnBm9NV5MN01Evjo3tqN1kP7?=
 =?us-ascii?Q?FKGkGFtDY9h8DetYmUaoOWdcpbzFiymdwywtgmuhF0gSpvKX6U4plF9QUjZT?=
 =?us-ascii?Q?yHq2TGwou8C204FSSiWeWSmthkEwPq/mEIaK1lLv9q6wMkf9hyVgwUb4hknQ?=
 =?us-ascii?Q?nx2WyqNU4aqBZXbpetzHtyVt/JPq3tJKkgc5pGnKI8V67UrarxOCH6Rw23/R?=
 =?us-ascii?Q?bOg8Hq7Ru4uMIqJAwSIH4aiV+MavGOFl/Q8MOLNk18UcP2VVkMCZ5Iq97NHR?=
 =?us-ascii?Q?KVr3cKYKQ1Yk8LbdbjSZdNSwvrFaJJ4ILN6tUnVEVfl+OD6QBdNJhFJEUd1s?=
 =?us-ascii?Q?Cbny6IIp7cR/lyP1/ECnYTefTJO24TTIZBzpSn4D4a91Yel8CIK5BkqbTPjq?=
 =?us-ascii?Q?j+kpLQppIJXhet6kaWVRklwSmjavKiHFL4jgZG4AUSL37SqjXm4KC/3CnMje?=
 =?us-ascii?Q?KY/zZ3Ug9g1O08ShSQTDoX2Gx0MEsEJJzK5FDFZAUt9jwgzdOcrBWIwAzfxo?=
 =?us-ascii?Q?0PxMay0fGYssMqPA1mIoI5YUfs8jQWHR673mQF/cfGEVJxtYek49U6lUFnPO?=
 =?us-ascii?Q?6Tdq50wslCfGJCBG0JwL2Pbx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d2e573-5796-4877-dcfb-08d8d846874a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 22:01:09.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2YG9cfzOQOAq/Y7WiVaqlA6IwJjwLkbxX6k+zlYvqKAdqpcOD4EjB7BQYEy5mEwX2Gvvd1jThdx8U0M1LZlQ7corPNQNeUhCc9LfYADPKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0183
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, February 23, 20=
21 6:30 AM
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
> >  drivers/scsi/storvsc_drv.c | 63 ++++++++++++++++----------------------=
--------
> >  1 file changed, 22 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 2e4fa77..5d06061 100644
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
> > @@ -1759,7 +1758,7 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct
> scsi_cmnd *scmnd)
> >  	payload_sz =3D sizeof(cmd_request->mpb);
> >
> >  	if (sg_count) {
> > -		unsigned int hvpgoff =3D 0;
> > +		unsigned int hvpgoff, sgl_size;
> >  		unsigned long offset_in_hvpg =3D sgl->offset & ~HV_HYP_PAGE_MASK;
> >  		unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + length);
> >  		u64 hvpfn;
> > @@ -1773,51 +1772,35 @@ static int storvsc_queuecommand(struct Scsi_Hos=
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
> > +			 * Init values for the current sgl entry. sgl_size
> > +			 * and hvpgoff are in units of Hyper-V size pages.
> > +			 * Handling the PAGE_SIZE !=3D HV_HYP_PAGE_SIZE case
> > +			 * also handles values of sgl->offset that are
> > +			 * larger than PAGE_SIZE. Such offsets are handled
> > +			 * even on other than the first sgl entry, provided
> > +			 * they are a multiple of PAGE_SIZE.
> >  			 */
> > -			unsigned int hvpgoff_in_page =3D
> > -				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
> > +			sgl_size =3D HVPFN_UP(sgl->offset + sgl->length);
> > +			hvpgoff =3D sgl->offset >> HV_HYP_PAGE_SHIFT;
> > +			hvpfn =3D page_to_hvpfn(sg_page(sgl));
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
> > +			while (hvpgoff !=3D sgl_size) {
> > +				payload->range.pfn_array[i++] =3D
> > +							hvpfn + hvpgoff++;
> >  			}
>=20
> Minor nitpicking: while this seems to be correct I, personally, find it
> a bit hard to read: 'hvpgoff' stands for "'sgl->offset' measured in
> Hyper-V pages' but we immediately re-use it as a cycle counter.
>=20
> If I'm not mistaken, we can count right away how many entries we're
> going to add. Also, we could've introduced HVPFN_DOWN() to complement
> HVPFN_UP():
> ...
> #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
> ...
>=20
> hvpgoff =3D HVPFN_DOWN(sgl->offset);
> hvpfn =3D page_to_hvpfn(sg_page(sgl)) + hvpgoff;
> hvpfns_to_add =3D HVPFN_UP(sgl->offset + sgl->length) - hvpgoff;
>=20
> and the cycle can look like:
>=20
> while (hvpfns_to_add) {
> 	payload->range.pfn_array[i++] =3D hvpfn++;
> 	hvpfns_to_add--;
> }
>=20
> > -
> > -			payload->range.pfn_array[i] =3D hvpfn + hvpgoff_in_page;
> >  		}
>=20
> and then we can also make an explicit
>=20
> BUG_ON(i !=3D hvpg_count) after the cycle to prove our math is correct :-=
)
>=20

Your proposal works for me, and it doesn't actually change the number of
arithmetic operations that need to be done.

But I don't think I'll actually add the BUG_ON().  The math is either right
or it isn't, and we have it right.

I'll spin a v2.

Michael

> >  	}
> >
> > @@ -1851,8 +1834,6 @@ static int storvsc_queuecommand(struct Scsi_Host =
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
>=20
> --
> Vitaly

