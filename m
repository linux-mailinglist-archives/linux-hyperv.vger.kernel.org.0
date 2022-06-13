Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04DD547DB0
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiFMCtR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Jun 2022 22:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiFMCtQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Jun 2022 22:49:16 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8845B366A2;
        Sun, 12 Jun 2022 19:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0S0ZuXCP/+5MCKf17P36wjkHSYHjsM2D6TvYzu1bOzW8YrUIW1hNq+sgR98mMwWntZk3cCcQIM+1z6tAXZ3mhM57F3h05r/bBQvSC+1HNM/zMBXZKokH+H5LKgO7706qp06KSltar51mM9xpuLPVEWTmJGajWNTkqJuC0UImT4LkV2wIHCRaxji7HZdZf5OKUNjXu5CzbuR6jh4GCu3AYo4hNBoPfLUjA0Fm00wCKsxgXY+v6mhxH0icOoo7hualMwHsibVfywADPxh7ADbA/nB4rKEPUAkMFdLgP2xCtdLjhR4DPGBCuvMsEavklouzaRqbDxEjY0KSu2s91VVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs+Xjt/scnVpydeuIU9jF8/BN/lQO7xH1vi1GONFPNM=;
 b=KqJFiSx83UY7FZOoaN42UmGA23LIIvCCyL/4WuhpAV7isMf1q7KX9sHLfhBPmqS/Cf4SUZie7GHtEzGu7cbLldhK1FuSE08AWmknq9yg1hPRrFScqqDhdl7WSTqwh6dMfTdv18rZVTs+Pe+CgmWbAY119nxAo6ERXDKYXZnrwlntD/cFH/Jn+EaUKmhH2iMz+MxURKo/w5NMTN8d4jC1VkzLrYHS8TrxygDp1tZJepP3xKf01hsbon/zPZ43mAjI1HI/d4qC3YDDn5XA1N+ns8pqelkL9xoCV+bIFByKIxDp8miGXVIj/cfzI1hix3hD9Ofw2Mr8YGodCa1tgkE7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs+Xjt/scnVpydeuIU9jF8/BN/lQO7xH1vi1GONFPNM=;
 b=Q2WosrB+kZ/rhcA+W+UN8A71ikaFSSi7X/Pe3E5Rcu6kMqXyaMZfHBFnUti/pkvOYz+g5qPbX1+LhoBm1YXit6pWW2nREmtTGpaSvKATH9am/g/cRhSqcFVx1vqwQpcLzXqFnvsFndtyRFiqLhNkUclOvnOt254cTgI0w84sJos=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN0PR21MB3072.namprd21.prod.outlook.com (2603:10b6:208:370::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.6; Mon, 13 Jun
 2022 02:49:09 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Mon, 13 Jun 2022
 02:49:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: RE: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V
 storvsc requirement
Thread-Topic: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V
 storvsc requirement
Thread-Index: AQHYfOffcwDOvnJng0mq0yy4aXRYHa1I1t4AgAPGGEA=
Date:   Mon, 13 Jun 2022 02:49:09 +0000
Message-ID: <PH0PR21MB3025818CA2E6D9641B878A7AD7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654878824-25691-1-git-send-email-ssengar@linux.microsoft.com>
 <20220610163714.GA25982@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220610163714.GA25982@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8182b9a5-f6f7-4fe2-bcd2-221b56d4cb50;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-13T02:15:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 324e78d5-b866-437e-d725-08da4ce74a36
x-ms-traffictypediagnostic: MN0PR21MB3072:EE_
x-microsoft-antispam-prvs: <MN0PR21MB30720465A0437649FE2B8FEBD7AB9@MN0PR21MB3072.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2pZTKGIkH1aFlvea2Wy+Tvbp4fPqoq2JpuIlCQLjbhzHnycD+KuTlDS3b+OsPnnwBIh9e6RfyQpjjwIiaCI3WD5iPxxCDyz1Tw23DqTup63N4d6ofeMxPui6DQnbSwP7mvohcgdo7x7hYdsMNGKWv/NphpkiBV36rjJmzAoNYF6LiRxNh5QAMliZvdNpmCisCkrgmbHXrbgdhBIb+3jGuDfqKggasin907pVRQr9EnKm740eqZnfND4RZfXS7gdCHrjekVrmgrteFvqqNgFa89DHpjEGYLj7RW87UyyEM8srYy0Pyc207p3wTmEvYtUAql388MNUTkF7QZMxX2uKxfCdeFvIDiU4soll42cpYsnzTNJvsuH5NayhT6cXlrJpLezYlRLdjWY5XrJLrdE3ZS/ToVnXhXyM3eHQtKYoYrly2RR0JJom1VZvANxc/HwITE2U2HIrZNLi5hvze/nCgK6GJ+GLrxlnz7B6CYXORpnNy+ygaje2YNmPEmWq2pA/3KrKVP5bGOTXfIPMK5QwQ1zLUyQ4D2bUhCZtmZaF/UB1WW7eaf6PMxQmXNPUfBTtX2j69vygHH34jopJDxZa8vVGgjD8MYeSh/w2RPbibOG9EZGmRYWITtDa1wXk9JNW4nDTLJ5+kIakZ6DQIAbht0gb/UJjbBxj3PqHjmymvkZIa4uKy576XkD2GaSwd1ko8U1KZ13mwlEImhhgIidBfOUzIZshuiC0RvyaRyEkvtvIynbWrBS4v/Uiy+7iJLZ+N6QKSBi3O8lOmcYwb70XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(5660300002)(2906002)(8936002)(55016003)(8990500004)(83380400001)(52536014)(921005)(38070700005)(82950400001)(82960400001)(122000001)(508600001)(66476007)(86362001)(38100700002)(66556008)(71200400001)(66446008)(10290500003)(8676002)(64756008)(66946007)(316002)(76116006)(186003)(7696005)(6506007)(110136005)(26005)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oychcwxgrXd4fjO3Q9pRQQ2WU6QZf9xIYuaOFMmNfLnW/gnf8l/8gu730bDZ?=
 =?us-ascii?Q?Mk4y3NcAfyNYUdxydFihlg2zs93k+0SWgdQUyhKhlxVYLK8rd0rotCIXaWaD?=
 =?us-ascii?Q?XS4a4aazsH/Cbv9782uessvNf7K6erkxL4hRA1TpoJwHcvFNswOEtERE20U9?=
 =?us-ascii?Q?Qslpfm74HYBKhM7ZS8Rd1UVOYHO4AYmqYl2j3sE8nQsxpvTmoRFTSiYZXARL?=
 =?us-ascii?Q?wqcX5b3Rl6YoYXu67+p0WQwBmf4rzw7Kbc/8c1Z4mh6Q1WpweyoTtF77t7VY?=
 =?us-ascii?Q?+XAxtRT6PQWpmULfzoQ18FN40Q7Duv559RaQisoXorLG7p2BVlJawH/V4JV9?=
 =?us-ascii?Q?wb6zkWgIFQAduHhPzxOLOux7ajjgoqj0bfNtCOnYxw5i04l5mvjWRiF+5Aln?=
 =?us-ascii?Q?mF/LId6c4AU6Le5B8i83wYTBfUK7lUI8wh1xnnvrvZTUtMl6JvjvTCVVVWwa?=
 =?us-ascii?Q?upKoHzos+sMJ78bzfU+xmX+Yimp0/sqA5TW/0cozyToO0wpnZVGWHByixo+C?=
 =?us-ascii?Q?gv90HDt9mIpemCw/fAhLoSNTihx0lSWaZCfyL3zwzmNbECfTT8VV91hX7DNw?=
 =?us-ascii?Q?N5dOVPFc50R6DdLhHIFsaEDyaFYQDFwrbjPG3aiOLzyEBNP+pBFiC6DaDINe?=
 =?us-ascii?Q?Zv4LRvVgUuhlWp7UKQQkn5HvFTLOrMS6tA6ZKNbmqN4hBNkaoDEIpzriA3eR?=
 =?us-ascii?Q?bGUSqM/8RUZ6qcAs75hB3CD8ydlhSIcZXKIUNUJwqiaviWC2+D/u4JHlP5Jz?=
 =?us-ascii?Q?NeyRPq4sReskO6V8gJLaIKqM7eerWH3iJiPFSebnELRDX8WjRyFSLqpn4uCl?=
 =?us-ascii?Q?N7aOx+uVvbAJ/TnSJZt1/xL75gA2plh8poLbQhoZKctXqTlDIyXC3vJG/LoO?=
 =?us-ascii?Q?EwW98sCYFIEYRG/uY5JUIfnJZUSHkQJ+F9wnbDyJobFCrIQd8geQeiMTc73Y?=
 =?us-ascii?Q?YunVT2uD8v9xrHbX5+3svpc1FDv6TIFzYCa+t8v/PAvxVJjmywIRWeaamGeQ?=
 =?us-ascii?Q?3Fo43/PFlkIX41OjfYg4/p1YiGX6mEKhxjl7MEWm+tEb7UThg8mI+MHBTDbX?=
 =?us-ascii?Q?YgFDxIEZkch29TxJG8b2yW0+QlOrMjpNCuy7Lmm2Kv/bSi4PBrjCXs/NiMpY?=
 =?us-ascii?Q?dfa8LtdJEn06A/SG0LF9FP7FiLttJvAw/nCjLox+3WWwsVpedxTNf4yG0/kg?=
 =?us-ascii?Q?OP25fAVqpr1tzdUv0AnmwbNpTAdM3suDAzzFVCZYQpLqcBXw2dV6UrxDSQ0S?=
 =?us-ascii?Q?OrdH4M07OhH22C/Dprn1ulcTisU2noMpFhBeNE6G1OadGoLjjAlupioECZdy?=
 =?us-ascii?Q?Uk0Y3xj1+1swmnZu4D8SzZcTjpDaLKAyHlkJeYxJtLhSR9Ci6q1oNW7Gzzke?=
 =?us-ascii?Q?/iIEynzX7HnVxQTy3tfN2rbi1b1+79zdnZkjiftf0NgKkdYC+ZmNRp7L7Yhe?=
 =?us-ascii?Q?qdfMS8sl0N4QtluLtmHpE1Sd+xOpuAYCe1RMTESPHaViv7tpAGRhGLCuiR0a?=
 =?us-ascii?Q?MXjwpdnrq4zgdyfnwsdzTIJl4kZvXKJONZFJPpRG/FuJNupZoOS0N1eCqLOC?=
 =?us-ascii?Q?+9XS+Y9yumxjBeKmENZagH6rGKfpNrg3Mt6S12W1amDcfZtXZUzvUpqBWPdK?=
 =?us-ascii?Q?1qr7ajM433IumgBAfJpJePxz+HzpamTwjOhj/jGD70jqHg+2btfexLPbSVpa?=
 =?us-ascii?Q?ExC5s+1K+50A2c4w9aorW08XDBJC7Yz5ANQxZynardyPprDJPcUL74RhrkIm?=
 =?us-ascii?Q?iwAmWPot2mVkesbI5BiIkzkqJe05+JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e78d5-b866-437e-d725-08da4ce74a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 02:49:09.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ia0nJWtzSDzouXCwgZLBFm/GUANErj+cStV6hejkBbTjwP4Y2bg396PiLRdO10UxTS+uxoBfqTeizOXlhAVaHPzb8hAjyBQMUumI22NXDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3072
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Friday, June=
 10, 2022 9:37 AM
>=20
> CC : linux-scsi@vger.kernel.org, jejb@linux.ibm.com, martin.petersen@orac=
le.com
>=20
> On Fri, Jun 10, 2022 at 09:33:44AM -0700, Saurabh Sengar wrote:
> > This patch corrects 3 parameters:
> > 1. Correct the sysfs entry for maximum hardware transfer limit of singl=
e
> >    transfer (max_hw_sectors_kb) by setting max_sectors, this was set to
> >    default value 512kb before.
> > 2. Correct SGL memory offset alignment as per Hyper-V page size.
> > 3. Correct sg_tablesize which accounts for max SGL segments entries in =
a
> >    single SGL.

I think a richer explanation in the commit message is warranted.
Something like:

  Current code is based on the idea that the max number of SGL entries also
  determines the max size of an I/O request.  While this idea was true in o=
lder
  versions of the storvsc driver when SGL entry length was limited to 4 Kby=
tes,
  commit 3d9c3dcc58e9 ("scsi: storvsc: Enable scatter list entry lengths > =
4Kbytes")
  removed that limitation.  It's now theoretically possible for the block
  layer to send requests that exceed the maximum size supported by Hyper-V.
  This problem doesn't currently happen in practice because the block layer
  defaults to a 512 Kbyte maximum, while Hyper-V in Azure supports 2 Mbyte
  I/O sizes.  But some future configuration of Hyper-V could have a smaller
  max I/O size, and the block layer could exceed that max.

  Fix this by correctly setting max_sectors as well as sg_tablesize to refl=
ect
  the maximum I/O size that Hyper-V reports.  While allowing larger I/O siz=
es
  larger than the block layer default of 512 Kbytes doesn't provide any
  noticeable performance benefit in the tests we ran, it's still appropriat=
e
  to report the correct underlying Hyper-V capabilities to the Linux block =
layer.

  Also tweak the virt_boundary_mask to reflect that the needed alignment
  derives from Hyper-V communication using a 4 Kbyte page size, and not
  on the guest page size, which might be bigger (on ARM64, for example).

I don't think the title of the commit should focus on sysfs.  This
commit is about correctly reporting Hyper-V I/O size limits; the sysfs
entries just provide visibility into the values.

And given that the problem was introduced by the above mentioned
commit, it would be appropriate to add a "Fixes:" tag.

> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index ca3530982e52..3e032660ae36 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1844,7 +1844,7 @@ static struct scsi_host_template scsi_driver =3D =
{
> >  	.cmd_per_lun =3D		2048,
> >  	.this_id =3D		-1,
> >  	/* Ensure there are no gaps in presented sgls */
> > -	.virt_boundary_mask =3D	PAGE_SIZE-1,
> > +	.virt_boundary_mask =3D	HV_HYP_PAGE_SIZE - 1,
> >  	.no_write_same =3D	1,
> >  	.track_queue_depth =3D	1,
> >  	.change_queue_depth =3D	storvsc_change_queue_depth,
> > @@ -1969,11 +1969,31 @@ static int storvsc_probe(struct hv_device *devi=
ce,
> >  	/* max cmd length */
> >  	host->max_cmd_len =3D STORVSC_MAX_CMD_LEN;
> >
> > +	/* max_hw_sectors_kb */
> > +	host->max_sectors =3D (stor_device->max_transfer_bytes) >> 9;
> >  	/*
> > -	 * set the table size based on the info we got
> > -	 * from the host.
> > +	 * There are 2 requirements for Hyper-V storvsc sgl segments,
> > +	 * based on which the below calculation for max segments is
> > +	 * done:
> > +	 *
> > +	 * 1. Except for the first and last sgl segment, all sgl segments
> > +	 *    should be align to HV_HYP_PAGE_SIZE, that also means the
> > +	 *    maximum number of segments in a sgl can be calculated by
> > +	 *    dividing the total max transfer length by HV_HYP_PAGE_SIZE.
> > +	 *
> > +	 * 2. Except for the first and last, each entry in the SGL must
> > +	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE,
> > +	 *    whereas the complete length of transfer may not be aligned
> > +	 *    to HV_HYP_PAGE_SIZE always. This can result in 2 cases:
> > +	 *    Example for unaligned case: Let's say the total transfer
> > +	 *    length is 6 KB, the max segments will be 3 (1,4,1).
> > +	 *    Example for aligned case: Let's say the total transfer length
> > +	 *    is 8KB, then max segments will still be 3(2,4,2) and not 4.
> > +	 *    4 (read next higher value) segments will only be required
> > +	 *    once the length is at least 2 bytes more then 8KB (read any
> > +	 *    HV_HYP_PAGE_SIZE aligned length).
> >  	 */
> > -	host->sg_tablesize =3D (stor_device->max_transfer_bytes >> PAGE_SHIFT=
);
> > +	host->sg_tablesize =3D ((stor_device->max_transfer_bytes - 2) >> HV_H=
YP_PAGE_SHIFT) + 2;

This calculation covers all possible I/O request sizes up to and including
the value of max_transfer_bytes, even if max_transfer_bytes is some
weird number that's not a multiple of 512.   So I think it works as
intended.

But setting host->max_sectors means that storvsc won't see an I/O request
with a weird size, and some of the cases handled by the calculation don't
actually occur.  You could use a simpler calculation that's a bit easier to
understand:

host->sg_tablesize =3D (stor_device->max_transfer_bytes >> HV_HYP_PAGE_SIZE=
) + 1;

The "+1" handles the unaligned case you mention above.

Michael

> >  	/*
> >  	 * For non-IDE disks, the host supports multiple channels.
> >  	 * Set the number of HW queues we are supporting.
> > --
> > 2.25.1
