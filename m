Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1D2D3181
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgLHRxb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 12:53:31 -0500
Received: from mail-eopbgr770093.outbound.protection.outlook.com ([40.107.77.93]:8094
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbgLHRxb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 12:53:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7Efx1cmSAyAolXukEb6yw+LnCJYFL/dvx3lX7CgIZbckBg8/0LFaCzVtjBlAo1+rmvuCzyXMX8k5LeZUUh90O9roa0KmyhJ8ud2GkoPbM08qBpzc4ZkWmTHeUyQislha26QG+S7UGBx1aOzqs1tVPzC5/Nmgb+KgxOkYiBH4aXq8Ikl6oZrp2JAUXZFoFpteKvC+lf6Xol0edlqAWAOXwyNBlj36WROXdtK1XXtoukRX88cAGhO8n1WuNMXLXt43/pwzfZMM+9z96c0cFMRo9Nt2P0IU+oXG7YhEmS6rVOjvTrU47KazZvmdlKmiMXOrG+KnSaPVC2XKBMW2yce1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbZE2UOvZbt1LPtrdvI+OPZiUoMzSYXW+lnUTArHShM=;
 b=abUkJ5SdIzCFhZgxkk+0DDxNu2GAWHyPy6pgxAmjdaqLjt58uV7q9G4b+ICGR//YFn+RR6L72MJtY8g9RiAh6/ULa6UCRzfQbz4wzwuO437mPNJy5vG1tP+MJJQuKTcWyEu7SaEf160bm2tjzjVXVtZnKXHKRCHjL7Z51+g0WuH2sUji8XTiu8YGFQts9sPzFP5mHNSbthMONyGcQWbSv6BTJFghyDazKrp+epuGVlfUS00NgFZVQNZPksnfsLtGd8mfpD4O6ql/tlmWs1fiA0Ywyxmt5fpGMlBjcHpj6Z5TwR8SJf9JnGPNBzg7K8FbSxuw30kyTd2P+VF0E60ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbZE2UOvZbt1LPtrdvI+OPZiUoMzSYXW+lnUTArHShM=;
 b=H6wRbRk7ir33STzCC88aMqbAhFYecj7AiFVVLEywQkkZzKUXMexa5o6gzC9oftk6gckfcnghidbSig67degrOGwo7GpHtlR3wZrh9kLrXBXEendo7Xv29K0Jl08mJT8xHxf5fNXvmZw03tXPLkn5hS2w3y33DLS4pDWiez57BrU=
Received: from (2603:10b6:302:a::16) by
 MW4PR21MB1905.namprd21.prod.outlook.com (2603:10b6:303:7e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.3; Tue, 8 Dec 2020 17:52:42 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Tue, 8 Dec 2020
 17:52:42 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: Fix possible buffer overflows in
 storvsc_queuecommand
Thread-Topic: [PATCH 1/1] scsi: Fix possible buffer overflows in
 storvsc_queuecommand
Thread-Index: AQHWzWd6P9XLO1eDwEKLOL3Kqxi73anteB5A
Date:   Tue, 8 Dec 2020 17:52:42 +0000
Message-ID: <MW2PR2101MB10523F50AA4497A9E116FBC0D7CD1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
In-Reply-To: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-08T17:52:40Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69d453f0-3090-4f05-ba28-55aea62fedcd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9611477e-1265-4da2-787c-08d89ba20fdc
x-ms-traffictypediagnostic: MW4PR21MB1905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19050F118031040FC52C67F4D7CD1@MW4PR21MB1905.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gZWhneCfWgIHMiVbdqqT2UNxcdURysgLz1hcFJ9KFK5iroNga189EwnR/S8tvmAg8fhuU0Y+P72BtVIxybl9F8qIxkyxhnpJekf/VTwJlRKPsnJzhCDcH5EpXe1/SnK3RvjC9UNR6OZP/KgDAXmekGYwkxVLaosNIQhj8lzbT3GbZ74BPyZ6xzA+o5pQnRION5AuT9zDRepSfoo9aPXLXi5m2dyVXCcoj653QZahscZds5kSp5MVjlb1xoGznxTNgLjO1Ax8IsUXvGb88pw8QrXdNBd+5m7mPIWg018BerhI05QGr7WvtA/jvmThWQZNOwDffg2sIvIzOPkKc7mKGy0JKFOpQDzamFeey4gBnGCmcg3XGPOPZcGLH8Tlpz/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(33656002)(8676002)(921005)(2906002)(86362001)(10290500003)(26005)(508600001)(7696005)(55016002)(186003)(71200400001)(66556008)(52536014)(82960400001)(76116006)(8990500004)(6506007)(82950400001)(8936002)(110136005)(66476007)(64756008)(5660300002)(66946007)(9686003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Imf3MXk5Phw7lNM6xjsxCz0D7EyoPYkP2iNxqaVi3NBnWXEJT6JVV/BTFGAM?=
 =?us-ascii?Q?e/5TtCkV/cOdRJcSxAesisazbp8d+iuU7JHzlpi52XPEocFr+EDahvOce0yg?=
 =?us-ascii?Q?78YtetUd3/Wxsohd68kFfBUAGN2i5aFciRI5gPIns2apXCGUon1ZG2P6tiH2?=
 =?us-ascii?Q?MO3wZbTEPyM6WB0WCFWz25gd98JLSeFRjNm98QVG0/vLStdlzP+aDuYX/Q+j?=
 =?us-ascii?Q?UHl+yKHrDHd6RryHEYfh42gA5cIXAatiDBV/OjmH4ITF6tpU6EELG7baFsZs?=
 =?us-ascii?Q?Rz85mKIL3cbK1eaSLJ6jPxN+90c5g7SCOAEgjVGCDk4WlicVHn1vf/ww3N9a?=
 =?us-ascii?Q?ZYodmCiGAnw+LwmX3zadUqQOudne1nu4Mb9cfWtjqH3MJ8WbubGaR/QjO/Fv?=
 =?us-ascii?Q?5Nwta71IG3NcFnNave9+j6NQVq7p2kzTnq2IjVydCSZZKa56J1vGUpMLnHun?=
 =?us-ascii?Q?MydAwIpHRJpGZKjx2q3ZzJHimqifLW0fjxEGo3SH8kFbWLsLROoM3crLfaUR?=
 =?us-ascii?Q?TyPLj6HVxNJQSNygACRiUwXomOAaB9d9Q6QMf4OsnOESC1XCChKBxFt//Gz0?=
 =?us-ascii?Q?zVl3w7V+P6xauoywts6EY6ZbMr65xR01Lf2rqdaGYr018giK3HHVBQGa+TQf?=
 =?us-ascii?Q?3xkCEKPmUI/AWEIqDlW2I8h8ba9WbNcbBcpBTeljzKusI/SAC2eQ5c/cdIXR?=
 =?us-ascii?Q?xeLwYznVItWEkYU0Sy1rY0rM6z0Ow3wYJHsUxH08jgSYvPN+3UZRd+ftKdQX?=
 =?us-ascii?Q?vuPu6d0WUOTNEpq4n+Rg8wIDUeW5Mxj1Bp8pih8ouVm3OuZGppfxSyCaHfW9?=
 =?us-ascii?Q?I9Ojyocw3GMbnz3w1cDCfGJDIsyFdfozKbRoqFknv2sTyCxB/hUVwLYnLHBJ?=
 =?us-ascii?Q?2rzEAeBY7KGLF+hWnDqkF14V+AgKuOR+k7g/JLkFxWZhp5lWzcP165YnKLHS?=
 =?us-ascii?Q?/6OFx4xEpDnT99bkjyIyKez9voPZ6z3G9VutGtYkupc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9611477e-1265-4da2-787c-08d89ba20fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 17:52:42.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9Pp6Ee26mLfE+UDiSpDRDTDSScGu47UTS7RwlC77XhJep0gzIAO04jKcyY6jTleUJWaqaZVeh7yISysjJY0hyUYNaP0bBYh+HLuCFsyLcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1905
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Xiaohui Zhang <ruc_zhangxiaohui@163.com>  Sent: Tuesday, December 8, =
2020 5:19 AM
>=20
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>=20
> storvsc_queuecommand() calls memcpy() without checking
> the destination size may trigger a buffer overflower,
> which a local user could use to cause denial of service
> or the execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().
>=20
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/scsi/storvsc_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 0c65fbd41..09b60a4c0 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1729,6 +1729,8 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost, struct
> scsi_cmnd *scmnd)
>=20
>  	vm_srb->cdb_length =3D scmnd->cmd_len;
>=20
> +	if (vm_srb->cdb_length > STORVSC_MAX_CMD_LEN)
> +		vm_srb->cdb_length =3D STORVSC_MAX_CMD_LEN;
>  	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
>=20
>  	sgl =3D (struct scatterlist *)scsi_sglist(scmnd);
> --
> 2.17.1

At first glance, this new test isn't necessary.  storvsc_queuecommand() get=
s
called from scsi_dispatch_cmd(), where just before the queuecommand functio=
n
is called, the cmd_len field is checked against the maximum command length
defined for the SCSI controller.  In the case of storvsc, that maximum comm=
and
length is STORVSC_MAX_CMD_LEN as set in storvsc_probe().  There's a comment
in scsi_dispatch_cmd() that covers this exact case.

You are correct that we need to make sure there's no buffer overflow.  Are
you seeing any other path where storvsc_queuecommand() could be called
without the cmd_len being checked?

Michael
