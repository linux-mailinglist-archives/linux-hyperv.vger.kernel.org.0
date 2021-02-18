Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCE31E57F
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Feb 2021 06:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBRFZ2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Feb 2021 00:25:28 -0500
Received: from mail-co1nam11on2100.outbound.protection.outlook.com ([40.107.220.100]:63584
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhBRFZ1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Feb 2021 00:25:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obbZ1+/jcO1tRKoycp2cqW1op4aPgQ2D8uUu+g+QT3Sez17qIMbAFEUdpXlNt2l/1gJL9gpLInxoH6M+9+C8tRRvRVJ8aiqhJB5M2R+mBYlz/nojAbN85HRvz67tBjH6CSdyRDFnRekCm1OnAlKrVmerzRe/YaP0eVNXBsU/8DbFcypPdjKI5+3TXW7fAguHd4y9RcA5qJtOd6Rc9OxJa0p2Nalwsu1Swpjtm8UmDgiVk3zTJQRETZ0ryA0vjVaGhyUbkS7glrbYNhjE9SPUuCOxzl8GdD47rEsxaigRJ3xXeFZQaz9AurvyNN0kmu7UYgCPBiESzPttFgr9uPgA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD7MLhDWEqAUpZUWrUoR3I4H4bNXgtqE/4Qgiz3sv6I=;
 b=lilw1uBo+ocpVSzGmr/ZeLE+wZvt8InPwq4cRc6BwPvUcQMvCdKLY+vFgvK4YJ8P0qo9YxTq/TW28w4r8P1VdgdHubX1LL1DTxKM9+lHmr3bo84XaSWhv4Aft9vg0p9LF23sLwaVXJkd01O2qTi8Ad9s7432EijQ3dae/GLfNFWqQ3TARKC1maeOxGsOif3zY0VbjU8NkMpFwC3v4AiUMSqi3ITKqc1ynqmkLkRKI4i+mPSDiyKtQ4oXiGljEVI65TgH8sjjv8W6CTMrAuCwiXmItstDZ5ZbMjgJ7k29H94YiGIKRxJ7woDZcbdM8KoSwnK9oDW7VbBiAWmLVAqa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD7MLhDWEqAUpZUWrUoR3I4H4bNXgtqE/4Qgiz3sv6I=;
 b=FnrCF+Mlilr7m9L3ze5Vb5m3BovfkWn8IBUB8PUDQp4FqgaeQseSkLbslwZ78Uq5krqCrprfYfKS4n/5eBMdKGQ3c7QrxxcunKn/KFjVCtxoC2lpQjY1JImeWrm84WwCj+30rrja0iuDV4xNbNQHOsuf3CqWgC72RUMVY/BWfq8=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Thu, 18 Feb 2021 05:24:35 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.003; Thu, 18 Feb 2021
 05:24:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     melanieplageman <melanieplageman@gmail.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Thread-Topic: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Thread-Index: AQHXAMx7G8GrUlQ5zUOjW2P1qe9C2qpUsILwgAhhSYCAAAHFMA==
Date:   Thu, 18 Feb 2021 05:24:35 +0000
Message-ID: <MWHPR21MB15930EFD2B324F7DBECA1E11D7859@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210211231803.25463-1-melanieplageman@gmail.com>
 <MWHPR21MB15932F068976333B8D3DCEFCD78B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210218000459.GA56402@goldwasser>
In-Reply-To: <20210218000459.GA56402@goldwasser>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-18T05:24:31Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=55e84aa6-7c42-41b6-bde7-3c54e710a882;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ed6ed0-4f81-4312-84a8-08d8d3cd7aad
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1956779FCED929BC3A3AD3C8D7859@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v05kHQ6e/5ErWVAd26qjU6XAqMeVinbd1y61OcuFscHGu+ebWKu25Jl7KXfUjBzl/wUgJ5pCrv0DyQB/c/iLQAKyaYRrq0y+rHw1F67SzweBvfUIxR+gOtn9R/0VvnI4MRkrPMdF6nXdGNuexLFWWSfmDRIJzWNHQOtGkGwpBE1iAd6b5UcgCKAId6ebP4Isrmql+T3VrDRRcM+wg5I99iBfMcmyWqz1mj7fFMKyeOllfYoZuuj/rXJuVhs7HNJRoz9OS6GBdQ/XRl0gCS/U4g1/BiSFFMEnzHup8kXsZWXTYaFvK34jUZ5i1uYoVmCSELM5TtaVPSGxhhKuP+P1zdbowXEo5QQvro0rRAUrR1d+T5IqzV6wNnHTKpoAMYobAR0lDpTrssPHgravzWSVxiOpI+ewhs39gEt7+Ov4g8NfFbmubLNqVnbE51KdZBaSTgkim+uruVnZNDNoBrmrrKPJmW/PE9LNaG7QT0/YeHFg7zrkMRamSyCgzs7FW3Nutoae5t5rU2ycSr+EgShFug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(52536014)(55016002)(7696005)(478600001)(66556008)(71200400001)(6916009)(66476007)(9686003)(33656002)(82960400001)(82950400001)(76116006)(6506007)(186003)(8676002)(8936002)(66946007)(54906003)(8990500004)(26005)(316002)(2906002)(4326008)(83380400001)(86362001)(64756008)(10290500003)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6EwOMaBl7qyVpWpGZ5U3aIft4W9RKa4NQyKEQiG4AlZfl78JTHmaOph6L1XG?=
 =?us-ascii?Q?t9r3Q6VUxKnjCVGVh1xynjt+6DJ86ZU/yrIJ+3q/8HUX3x7jABMbhXaVQsU3?=
 =?us-ascii?Q?rBam+p3iBpDvCPJZz++nSm+AZGaaHWNkCQY5tcwvTDH15SFy9AP2zw+mpRNq?=
 =?us-ascii?Q?Ky/OuCUIkVnxwextHSpHQP9nQOp4xVAbv3/FZsVeW5en++16KnXR70Ft2t+Y?=
 =?us-ascii?Q?P15oD6DSMhQ1v5L4w8CVBACWCLhBVQfzAJJ02x9s7iERdVQMOgnT0ZICOhDZ?=
 =?us-ascii?Q?NSKGHrTMY5x5OUfY8n924megnHQjRt1Clz6z3egvZIprgXyjQJZBBfzt6Rx/?=
 =?us-ascii?Q?qLoOEu7re58pC0e9Ot6B2BPfcVhdeKpdDFSY6haLtwboF7FXoPyCIuc5AXKU?=
 =?us-ascii?Q?C//Cpm5dgaOBrru72w3hMOJgXDOSbKqpbrjuQYhBr3+uGkW64eTcsMI+CSab?=
 =?us-ascii?Q?TWQCnW/368lMLM7GA15olkL4rm6S2LRr5jIyu0ex0GrtmmktzcE/pSYpCIH1?=
 =?us-ascii?Q?M9QNrfajgTvujxAN6R98TOShvpcN1WEHX4arLcYC24eAusP6oj+BkWin4gG4?=
 =?us-ascii?Q?8D4iFYVC9RFrSBxr8yvYDHq4awRrr8+zp0zRiuFhHvyM64Ium00xFiEK9f3W?=
 =?us-ascii?Q?UjNCYd4t06tdIZZxSKbm41l8OohnkXfSo08qV+m6JRu8JLXVF4JkeyMuuttz?=
 =?us-ascii?Q?GEU/yTD3vs+OyvyVtVPxnntfULwkVTm9NIlSyaD11XJcRImnzKJX4ppFFvWy?=
 =?us-ascii?Q?wUVK+zK2zyp3zGwm/Th9AfXfJKPmptvPk78Ju4TSCjPErs6Ho9L+0Au+4ktv?=
 =?us-ascii?Q?d949xLppYGA7P3Rxdt27ub0lhhHXOUoGvfFyBigJsGt0a/YHNhyJPS0WUIKz?=
 =?us-ascii?Q?bPojwl0ytfv0tnqCSb9x1HrVCj9twinA2uLemmjYSlppAI28dyaqVcERIwjs?=
 =?us-ascii?Q?cir8ypdew+NGBzpkBpktZeN1PRkuIiJq/JV3++CfWKRxEnIx8Rc1sLxoKJ9E?=
 =?us-ascii?Q?V7/orqmj2D35ozNgpGjTGm0/N1eWYIQxM+qVe04socir0YDhCKFSO6fJfiI8?=
 =?us-ascii?Q?hyO8r9bJ8a9qhqFZnMqTJwNatwMltLDjTKxqPu6cSRYZhNpG01zQBA+T6lva?=
 =?us-ascii?Q?Io0ke2IBlcLJRqBzusMT5lEy/aRdrMmQeD0mTPwN/9UmDq0delShTm4lCgOa?=
 =?us-ascii?Q?ajAvU2PGgPg2UY7fAGcxMs+KSkwxIXYDBwP4UXRstevLLViD2iPMmMpy1ZDb?=
 =?us-ascii?Q?FUb6jdRL0vQcGApRDP6AUTBOBB9Q5WEy6Ags0GWgB/LpkFWBSzsoqtvseEd7?=
 =?us-ascii?Q?bDZJWdsV+5/i3KYkGl2MlGO9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ed6ed0-4f81-4312-84a8-08d8d3cd7aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 05:24:35.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3svj3WsYSwcDJEBqSyFhH6UogmISR43znMZkgksd8uZzwTR6rcEmPdCh2O3wuqY/otntZreHjk2vteOkmRi04YyGDDgA7rKGum+T07tPL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman <melanieplageman@gmail.com> Sent: Wednesday, Februar=
y 17, 2021 4:05 PM
>=20
> On Fri, Feb 12, 2021 at 04:35:16PM +0000, Michael Kelley wrote:
> > From: Melanie Plageman <melanieplageman@gmail.com> Sent: Thursday, Febr=
uary 11,
> 2021 3:18 PM
> > >
> > > Add ability to set the number of hardware queues with new module para=
meter,
> > > storvsc_max_hw_queues. The default value remains the number of CPUs. =
 This
> > > functionality is useful in some environments (e.g. Microsoft Azure) w=
here
> > > decreasing the number of hardware queues has been shown to improve
> > > performance.
> > >
> > > Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.co=
m>
> > > ---
> > >  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++++--
> > >  1 file changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > > index 2e4fa77445fd..a64e6664c915 100644
> > > --- a/drivers/scsi/storvsc_drv.c
> > > +++ b/drivers/scsi/storvsc_drv.c
> > > @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
> > >  static int storvsc_change_queue_depth(struct scsi_device *sdev, int =
queue_depth);
> > >
> > >  static int storvsc_vcpus_per_sub_channel =3D 4;
> > > +static int storvsc_max_hw_queues =3D -1;
> > >
> > >  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
> > >  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)"=
);
> > >
> > > +module_param(storvsc_max_hw_queues, int, S_IRUGO|S_IWUSR);
> > > +MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware
> > > queues");
> > > +
> >
> > There's been an effort underway to not use the symbolic permissions in
> > module_param(), but to just use the octal digits (like 0600 for root on=
ly
> > access).   But I couldn't immediately find documentation on why this
> > change is being made.  And clearly it hasn't been applied to the
> > existing module_param() uses here in storvsc_drv.c.  But with this bein=
g
> > a new parameter, let's use the recommended octal digit format.
>=20
> Thanks. I will update this in v4.
>=20
> >
> > >  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
> > >  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to
> > > subchannels");
> > >
> > > @@ -1897,6 +1901,7 @@ static int storvsc_probe(struct hv_device *devi=
ce,
> > >  {
> > >  	int ret;
> > >  	int num_cpus =3D num_online_cpus();
> > > +	int num_present_cpus =3D num_present_cpus();
> > >  	struct Scsi_Host *host;
> > >  	struct hv_host_device *host_dev;
> > >  	bool dev_is_ide =3D ((dev_id->driver_data =3D=3D IDE_GUID) ? true :=
 false);
> > > @@ -2004,8 +2009,19 @@ static int storvsc_probe(struct hv_device *dev=
ice,
> > >  	 * For non-IDE disks, the host supports multiple channels.
> > >  	 * Set the number of HW queues we are supporting.
> > >  	 */
> > > -	if (!dev_is_ide)
> > > -		host->nr_hw_queues =3D num_present_cpus();
> > > +	if (!dev_is_ide) {
> > > +		if (storvsc_max_hw_queues =3D=3D -1)
> > > +			host->nr_hw_queues =3D num_present_cpus;
> > > +		else if (storvsc_max_hw_queues > num_present_cpus ||
> > > +			 storvsc_max_hw_queues =3D=3D 0 ||
> > > +			storvsc_max_hw_queues < -1) {
> > > +			storvsc_log(device, STORVSC_LOGGING_WARN,
> > > +				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> > > +			host->nr_hw_queues =3D num_present_cpus;
> > > +			storvsc_max_hw_queues =3D -1;
> > > +		} else
> > > +			host->nr_hw_queues =3D storvsc_max_hw_queues;
> > > +	}
> >
> > I have a couple of thoughts about the above logic.  As the code is writ=
ten,
> > valid values are integers from 1 to the number of CPUs, and -1.  The lo=
gic
> > would be simpler if the module parameter was an unsigned int instead of
> > a signed int, and zero was the marker for "use number of CPUs".  Then
> > you wouldn't have to check for negative values or have special handling
> > for -1.
>=20
> I used -1 because the linter ./scripts/checkpatch.pl throws an ERROR "do
> not initialise statics to 0"

OK, right.  The intent of that warning is not that using zero as a value
is bad.  The intent that to indicate that statics are by default initialize=
d
to zero, so explicitly adding the "=3D 0" is unnecessary.  So feel free to
use "0" as the marker for "use numbers of CPUs".  Just don't
add the "=3D 0" in the variable declaration. :-)

>=20
> >
> > Second, I think you can avoid intertwining the logic for checking for a=
n
> > invalid value, and actually setting host->nr_hw_queues.  Check for an
> > invalid value first, then do the setting of host->hr_hw_queues.
> >
> > Putting both thoughts together, you could get code like this:
> >
> > 	if (!dev_is ide) {
> > 		if (storvsc_max_hw_queues > num_present_cpus) {
> > 			storvsc_max_hw_queues =3D 0;
> > 			storvsc_log(device, STORVSC_LOGGING_WARN,
> > 				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> > 		}
> > 		if (storvsc_max_hw_queues)
> > 			host->nr_hw_queues =3D storvsc_max_hw_queues
> > 		else
> > 			host->hr_hw_queues =3D num_present_cpus;
> > 	}
>=20
> I will update the logic like this.
>=20
> >
> > >
> > >  	/*
> > >  	 * Set the error handler work queue.
> > > @@ -2169,6 +2185,14 @@ static int __init storvsc_drv_init(void)
> > >  		vmscsi_size_delta,
> > >  		sizeof(u64)));
> > >
> > > +	if (storvsc_max_hw_queues > num_present_cpus() ||
> > > +		storvsc_max_hw_queues =3D=3D 0 ||
> > > +		storvsc_max_hw_queues < -1) {
> > > +		pr_warn("Setting storvsc_max_hw_queues to -1. %d is invalid.\n",
> > > +			storvsc_max_hw_queues);
> > > +		storvsc_max_hw_queues =3D -1;
> > > +	}
> > > +
> >
> > Is this check really needed?  Any usage of the value will be in
> > storvsc_probe() where the same check is performed.  I'm not seeing
> > a scenario where this check adds value over what's already being
> > done in storvsc_probe(), but maybe I'm missing it.
>=20
> It is not. I had initially added it because I did not plan on making the
> parameter updatable and thought it would be better to only have one
> message about the invalid value instead of #device messages (from each
> probe()). But, after making it updatable, I had to add invalid value
> checking to storvsc_probe() anyway, so, this is definitely unneeded. If
> you specify the parameter at boot-time and this is here, you would only
> get one instance of the logging message (because it resets the value of
> storvsc_max_hw_queues to the default before probe() is called), but, I
> don't think that is worth it.

I agree.  And actually, if the code in storvsc_probe() "fixes" the bad
value, you would not get the warning on subsequent calls to
storvsc_probe().  So again, you would have only one warning unless
someone manually changed it to a bad value again via the /sys/module
interface.

Michael

>=20
> >
> > >  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
> > >  	fc_transport_template =3D fc_attach_transport(&fc_transport_functio=
ns);
> > >  	if (!fc_transport_template)
> > > --
> > > 2.20.1
> >
