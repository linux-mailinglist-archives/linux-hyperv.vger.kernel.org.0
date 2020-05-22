Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0261DEF47
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgEVSeT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 14:34:19 -0400
Received: from mail-mw2nam10on2105.outbound.protection.outlook.com ([40.107.94.105]:11489
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730798AbgEVSeT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 14:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCnN0Wa2ceDhop1Flzb6IX+F0ssU9D6PtZ2+I/C6ghZIziB6hbhGtnNoHgTvHj5LaT9mkC17hPKyfz9pY8NFVz+URXgmeptUQ+cVVNyEnrwr8jY6vQv28AdeshWJ69CN3Rmwba9kl3ZSChBDGS2YEeWxgNXsIAac/gpZfg3S2GwFyo/oJHHMIj0nwVQEqEXcKRcX083BYcBfYwudfp8HcX6K7z0oaBBCSMlFoTd9W1W/T3tJO0gqO/LmH0KPlVDF78d1dMGAtSk0NzqWQNPL6a+6hil4cYC+3ewyyW1NsH+Ja+ulCeLzRmvmIA5Oo8NIY7yg9PX4bh0EBrr/TI5rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p/IDs+yp69yvqNsky4UCT31F4vxm3vxrcMuPvmuyHI=;
 b=KJP/Lek/pPti98oi9R4AOHDA9dEGDy/WxVdaXKhsVa43KdjtKB5+5ppaCB73Hcu1VdJ9nZoDoo5KY2MWIMzlLyk5FaVsiIBQuSJI1hw4dYJTpyhAM2OlNvfBeA7eQvsubASESQIwzrn1nuqWDpz1xZqaQmU4/HypedhDXFqFOS4cB8jS3Ju2DWUuZi5PBc/3wOaDWE+qKz5IF6Nn3TjIKeNPYp2JkK6dppc01v3PicXucbYkClYNlWbEy3kpATRjiEiUqVjeZZMltdqffrdpeVVzU1BAJPFany7oDfYbBmct+kc6uYlJ1qtLaDl3cu8SA2sdckzOYWcb+zfI0CTpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p/IDs+yp69yvqNsky4UCT31F4vxm3vxrcMuPvmuyHI=;
 b=Cb8FMdbspAxSmPj4MlEZTZnNdk+bQwicGZ0RaZvZaEh4ERRyhZT2dKung6/Of0mhVT9zDzWltPU+HMXH8bUovLEb7siw6ibFl87MQo0OiZO8WujIK6jdm9ekhtKFRAarfmvSVGvxUWaRzc5M/z1zUeqvTvQkYa+T0/m8xtLK3DU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1034.namprd21.prod.outlook.com (2603:10b6:302:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.6; Fri, 22 May
 2020 18:34:15 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%7]) with mapi id 15.20.3021.002; Fri, 22 May 2020
 18:34:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Resolve race between
 init_vp_index() and CPU hotplug
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Resolve race between
 init_vp_index() and CPU hotplug
Thread-Index: AQHWMF02y64NPbAdtUulklFpuaSRq6i0bhnw
Date:   Fri, 22 May 2020 18:34:14 +0000
Message-ID: <MW2PR2101MB1052C380E026F86F34C19D50D7B40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200522171901.204127-1-parri.andrea@gmail.com>
 <20200522171901.204127-2-parri.andrea@gmail.com>
In-Reply-To: <20200522171901.204127-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-22T18:34:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0077a71-8599-40ba-8ef9-c3b07321d214;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93144a90-6943-4ddf-2df9-08d7fe7ebae9
x-ms-traffictypediagnostic: MW2PR2101MB1034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1034D1B9026DB860E80B4FEAD7B40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jqv7JxzKv7InYdIZqiVFwuY8PmmUWd8ewEkILFqglLjdLWZA4PmgBPtTKaE3rj1yCWdHbLr2LN4bNkufv58li37Xl/Jjr1q4X5rsG5cMrmDIdcHBl31OExSMjKBCW/qDXj3OzS0/6S/Fjp66FLNjKfFyeM/kyVPigVV/LNUZjVDuXqrUNQJ48KiB8ZEPgFGXicfeMxcRgiV1rMY6lMG0JwPSqIAYWQhM6cfBFRLZSKJl8c89qpQbAywxbQv8ndWG0Ajux8XgsFC3XBbrUocvNihs4scAtPAT7KeO3/Y2qgrRtC6h3G+0eVpCEygpZXCoiZiiJcY0ZojMlkAp70Hlwjrf784YMolo83Hngzb5v36TA4GXRUND9WgeNg5e4prrm/bA2KVowH0QlkQYpcNP4NTml5XRp5Ln/XCVOpmWpDHOnstake/RErLP65GCI1/V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(26005)(478600001)(10290500003)(6506007)(8990500004)(316002)(52536014)(8936002)(55016002)(9686003)(5660300002)(186003)(66946007)(82960400001)(82950400001)(110136005)(2906002)(76116006)(8676002)(54906003)(66476007)(66556008)(66446008)(86362001)(7696005)(71200400001)(33656002)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a3ge9qWgzn+p+0+GFZx4NohW9MU9FpbmX0JySwAJbdT/zNvrXCF91SpCdnFq+2oYiWh7eqH/hyvP++IkeEwbG8NNy5ldkPa/V6fVvyUe7YjhIKaHuVCMIymzv79kvmDKCf7PTyeW4+T6OSV708HGeTXKMUCZ5iUwaRBFO5N7tOwt7vtByyGR9zLqt6yFn2ttMMXfXxRi+Y1LQ+6M29S4hPQR2QzgWU3XorvFsO5f07zy3UGQS4rt0ZsPdn0xCqWerqys4V0YeGW3ISEA2OLgOcuMwDt9gqzzFyUwjAv1rvOK4eCtFmx7AwmjqTSX3wcUKaWX5J5h54RkfNiAip7eawh2iXOCM+KcWbU0zwFUXxE1PscXfLPe5/f9CGAG4CKkq9PQQX61zborjQceZB4h+rmSD97fJDY6Afn/C0dqkNHpkrUkVXLp9/8k56i58HblaXnLNbiGrSLvHbs9QJNwlXDqN3bg2xmFermD9adWP2dJ+2nMmpblK84avLYDsKtC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93144a90-6943-4ddf-2df9-08d7fe7ebae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 18:34:14.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErUaITKtFn0RzT5T88L+XMleIvNtyDyr4IELPqvtribH0grZOZNNo0MJ/Dl8y8c6RO9KD6+Tbzmr51rCjExF8ucYJpq/ZAj1A1JAQmyZTQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, May 2=
2, 2020 10:19 AM
>=20
> vmbus_process_offer() does two things (among others):
>=20
>  1) first, it sets the channel's target CPU with cpu_hotplug_lock;
>  2) it then adds the channel to the channel list(s) with channel_mutex.
>=20
> Since cpu_hotplug_lock is released before (2), the channel's target CPU
> (as designated in (1)) can be deemed "free" by hv_synic_cleanup() and go
> offline before the channel is added to the list.
>=20
> Fix the race condition by "extending" the cpu_hotplug_lock critical
> section to include (2) (and (1)), nesting the channel_mutex critical
> section within the cpu_hotplug_lock critical section as done elsewhere
> (hv_synic_cleanup(), target_cpu_store()) in the hyperv drivers code.
>=20
> Move even further by extending the channel_mutex critical section to
> include (1) (and (2)): this change allows to remove (the now redundant)
> bind_channel_to_cpu_lock, and generally simplifies the handling of the
> target CPUs (that are now always modified with channel_mutex held).
>=20
> Fixes: d570aec0f2154e ("Drivers: hv: vmbus: Synchronize init_vp_index() v=
s. CPU hotplug")
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 46 +++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
