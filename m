Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228B5304A53
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAZFIZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 00:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbhAZBl4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 20:41:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4F3C061355;
        Mon, 25 Jan 2021 16:39:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF4C3UHuqFah7A199dzc8+dLfd9agxiohlPp8FANJrymcsk+3dN1ci79vr6TbQ3Y9W0HsSqgLIRkd3kP4CuLpLbW/XvhQWvaC6EVHEeipIRa8JTXdgpHAQjNuSlbi8zAd+HBDgeohQLkiBUt2bw/I5fIjm4JwuEL2krOUCIeHhETzxA9vXdL8AryiRZrR1dgk9CtIh18vXkXaLet9PYI3LQ0r+ZwOnpUdqPiCthe3TX6H/mzDRXjRmRC9EYZQscVV+GyzmCFS2xPcZgO3Q4Gwfr1JxEIdFCA3WcDhGbCTVWzQAxGCyOXvA/9Kw7ZMuYhaV+A2ZtjWssBEKM59Sg8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHLLC0zOIxrSO97vcNgIlkW8rZQd4dKZiAeYubKHHSw=;
 b=kbKLqQzsNNAE/EAipx1irezzYv1X4WnaVEX0S+lOb1n7+ye65Bxr66+dCJaV1LBuvD/3LS/NMQSM+Uol2fvv3xkzBeSNk4OvVP4OTOB6icz9HXBPfDdtLBGWExPVqCSz6zMFBGhxdsCEQ+rJU1w34BlP4vybi+bQFLnPpQC/Zx9vxJLJNE0Pdpf1z9JwEdm/p7dXp0X79fM517tD3fhF4y2NPNJwWRTBKXfH97t2QtMloQcICwTidNbtaS+PWVgHhHp+Up3QHVLOoUgpgw1/thaZVt58LDi2qzufJ5nfjaTOmEUFkFDAEdPALK7FeWznasuoKda47JMtT3fK6qg6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHLLC0zOIxrSO97vcNgIlkW8rZQd4dKZiAeYubKHHSw=;
 b=NpIGoWQyrIHHhfYAZHLvLnBlqCjTTLDms/hDGRBwklnaXveqq0jCs7At80hEw1KbyDoXwenTRh/diCg/+7Q8ktFG/c1D3q0+ekbY+6ErW+P1O20ZInbDcFY4Ax4V+rQQCAf1OaqBJIL8V8ApYgfvmmXdW9ou1nCbhuHWbm5wTFE=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Tue, 26 Jan 2021 00:33:28 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:33:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Joerg Roedel <jroedel@suse.de>, vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
Thread-Topic: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
Thread-Index: AQHW7yPxJdqCn1uKJkS6fh32VfxBCao5Fz3Q
Date:   Tue, 26 Jan 2021 00:33:28 +0000
Message-ID: <MWHPR21MB159335A01C1DD12F021C7F21D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-5-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-5-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:33:26Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=23d4087c-2144-4232-9179-dcacad4f6c3a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2fe146a-f44a-4be9-bead-08d8c192004a
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0862F5EF894F6D8C70A9FCAFD7BC9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ys3xti8yxs0Yz9VGPLLobWT9QwpHXYx/Zm4COPbEGQ7gsJKofclCP1EsA16mAouaVURMm7SGCQpxIQawOgCxR93sOj+hdiZhIMX9pyeYgXsLIWwmZBlLi49YlE296BdU1mjEr6exiLU4JqFF8uZvH6gPz1MSyO+KCefNM5HwHFDrXGBvcQZosRSGbsx0Dy5IYs12K/0IQkNeo2HVKVSxkRvu9QT53uhhIWi7k5bQm4VN/NRuCpGdODfA8uec6nyxg9akfAaPwtr+/zQT328wu9DEx1x+sx4ED7d1WcUYllU/gg31QGx47O3KOuwBUx02SR9YRl39YdPQFdlKO6jtRAjPYwsS2Ejj6y4f7ryVW41tsnbSHylMMYOaOhku/3Otq+RiCGDBuxKJAb6wl6O3XScX/OpU+CXrG8fqH07tBBuRCvS8yxwzCMyUrlzbUwH8S0RQI2reuQCmkRGiuhNJquSdQP7SCPkqZM0qnLQu+Ais8BcX1UUgGiZEmBTF2Fbd/jt7gJKh82FXAXPYCp6t9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(83380400001)(7696005)(66556008)(76116006)(8936002)(9686003)(8676002)(66946007)(86362001)(66446008)(64756008)(82960400001)(82950400001)(66476007)(55016002)(8990500004)(10290500003)(33656002)(71200400001)(5660300002)(316002)(478600001)(4326008)(7416002)(26005)(6506007)(52536014)(2906002)(186003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nhz+sShRCX+ZzAFqvcN1x7b2ztg9d9SI+MzN+SOnbbz3/D8wlGTGc42FKqm9?=
 =?us-ascii?Q?RxzzOtzJxjzDmumW4IpR33fEqwJ4dpBzURjsvi5EkO0SH9rCGPnivXm8RTDL?=
 =?us-ascii?Q?igPmjstVGfwa2TRVplhr3uvqhgfUyubfjnmMDgvMQs73MqoGB9lVEnk9u3z0?=
 =?us-ascii?Q?sNtiuRPe5Lkxk7DTimEPmwzyrSdEsOhEwbTDuMHEJ6vckqA1eflacGb8hcO2?=
 =?us-ascii?Q?BQ80CpFRjXb7Fx57Z7Z6EI7l1qmS7rdynyGsPImK8rbUaD8dmX2xWt2pPMUk?=
 =?us-ascii?Q?o4k6YjAbBCDw57Q9NUDoZoLAz71r6KpW2sk78szuezFR0bg4GLvoOeJT7bNT?=
 =?us-ascii?Q?Kk3xItPT8mN+DgWoIoITiPILV/nGSKMDxOfXUnliphfCNu7yQ1tThBUU1nh1?=
 =?us-ascii?Q?Qj5rDThPh0RDrZV4vGIEZtX5FO6c8lcgxod7Ik/0QXrz/nNqFaHcyl9MyHnz?=
 =?us-ascii?Q?H+qxpaU9aejw0Jgcw4ByBQxQqHa2iSdS6wFsSVyb7wvU2kNd4rvLJk5zr0Qk?=
 =?us-ascii?Q?L+i355rqwS7jhzN6qhTrxzVm6jmiEqkB1ldHuyeYhZBzy4DuHFoop9Jk7Y58?=
 =?us-ascii?Q?uFuGjaHwa/h5ofGfGy+X/KDGr+4j0W30kV+xoFKtbKzaeNW/0iUYEe61KVDW?=
 =?us-ascii?Q?+4Czkj+0SfPojIoKfktSAFX0c0zXd0COCsVa760EYBgcuiAhWG4zt30c662P?=
 =?us-ascii?Q?EoC9O/VEX4AsbL0Z4fGaWDN6UL6CtAxy8LaIo65Q8oHM6S7y4/v5AZmdL+zj?=
 =?us-ascii?Q?CXUkYRm3JCD5KFN8kHRPIxWKa5DecR5Ls/Fbb/aluhBVM4WZ/GFFsVIxGg5y?=
 =?us-ascii?Q?/wuvFncRvE0UDzS20GR1kZubS5omzp/PRhbsyO1XmREZxpo54fubBI9vj1sJ?=
 =?us-ascii?Q?vhFvVbWrDoeAxk+95OnEe3PK9ebVwZJir4EsmRQcEsejp5FY4xgJ/YBibewz?=
 =?us-ascii?Q?AVntwlQYUR1BWRi0jW2cAaWB6sJPcjqdG9wRtCB/MGVBDlE81PEIWzzFtipj?=
 =?us-ascii?Q?aXaml3+R5QMz2aRMXRnnQI7T+HqDJkf5d6ocp1/9PmA6usgqfDPsvXThSTAu?=
 =?us-ascii?Q?/+W+Tf7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fe146a-f44a-4be9-bead-08d8c192004a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:33:28.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDffzNGyAFmqAsUxSxf6SL5hdp3xUJKju9NtNcGGDXmUCnxhyLWciUW6Bc1AhCl2V+NFa5slL0KLOM5vRhSsHWhztxEahQ+SkWyDPCByHSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root partition.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..b7db6024e65c 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>=20
>  #include "irq_remapping.h"
>=20
> @@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>=20
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>  	    x86_init.hyper.msi_ext_dest_id() ||
> -	    !x2apic_supported())
> +	    !x2apic_supported() || hv_root_partition)
>  		return -ENODEV;
>=20
>  	fn =3D irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

