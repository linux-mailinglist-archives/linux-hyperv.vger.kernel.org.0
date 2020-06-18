Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2821FF69B
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgFRP1j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 11:27:39 -0400
Received: from mail-eopbgr750132.outbound.protection.outlook.com ([40.107.75.132]:50693
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727841AbgFRP1i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 11:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN4n1NyJrq6NEjYq/nIgsEldfUdrMKS1EwY55TDmM1IbojifBLJOPRhYRHXxNiq0tPSEMtAOy3jU6TAK7K2CcV0Fnf6Lbc2YRArmPgY6VOfdr1ND35MRFlEqa5sAavlb5UDsG4etO9U7YekgX4l3FSiATFlDlNKlVexK4j7PtcLt5iID9m/pI8OCT3bkDtqd7Wcw5v/7Wk42E4DrIa6glylDcOuOGz33quCR6u94NRfffCz5y6uRONgP6nj2NpvgxyyW6kWEkzqLzsTno/zTsXuGyp8Zx+J6lONXs6755lVOT66nyVdIfZPtvo8VgwkWq6rtypLB5mFZl1EQ6OHjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JpjQ90muHhUcSUgR6QH2KR+ipNNKGTNnnLx6YOBrlM=;
 b=FYsdHWhYHlmKw1/S6AAAjchf6aPNO6qvBkjnw7S7JkwSA2KeXQ1mT7ClKGxaKxCTWS3HDs2dzsrsQ9iDnloZa9Zt9j/kgR9BILhRk06wIYhc7Hi8ZtUyNE0d2SgLwKs5qhOKbExARzIp/XvkEYriqteMyKiGFo8e4DqXQ05gLy48uCL8dJpc2NkQWcsCLGN6aYaKuL2emRYrE1nGoi7c+cP8qgq4nkFrvAUpWqGKAOWSn5yClJQDFJmpI7eGr38iCopnxoYzPrvVUYAgWKtK2ryQS5o50HqiglcySfTw/zbKtgoAqBYgTKYzIr+rOR8dWtPgjuHf5eSnTmC+irkNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JpjQ90muHhUcSUgR6QH2KR+ipNNKGTNnnLx6YOBrlM=;
 b=GRYaaP6qrcM+MEu967YAqvCQpmcAyFggsIfqbhDqrabGgzkqBpyEZQHenwKMcRo7b3w4/eVo3kv0qD4RZW9h4sN6QOv/seK9ODZ3k88EWwmLkZFok5Z0MDxQjZxYtJdDUOjYlTB3zutEhGkmLZqUF9skZL8mUBiJesD3aw4hgMk=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM6PR21MB1290.namprd21.prod.outlook.com (2603:10b6:5:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12; Thu, 18 Jun
 2020 15:27:35 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 15:27:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/8] Drivers: hv: vmbus: Replace cpumask_test_cpu(,
 cpu_online_mask) with cpu_online()
Thread-Topic: [PATCH 3/8] Drivers: hv: vmbus: Replace cpumask_test_cpu(,
 cpu_online_mask) with cpu_online()
Thread-Index: AQHWRMcNdm6S4LLDAky0Cm/qQY9X5ajegDVg
Date:   Thu, 18 Jun 2020 15:27:35 +0000
Message-ID: <DM5PR2101MB1047B24506389A4D25420323D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-4-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T15:27:34Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2bd3b2c3-312b-4ad3-902b-a874c112d29b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7b03e43-6572-4e15-c41f-08d8139c20a8
x-ms-traffictypediagnostic: DM6PR21MB1290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1290F36CB8B773BB00BEF065D79B0@DM6PR21MB1290.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz2deRow1TR5jYSBvj74scxgM5UOyVK+orK3h/Ii90IOTHq3NifBeCQ3QItm9EJWu83xpCWX97iS3Ne+8QimkG2CMOPXmK24h6XSNyKBlTueg2b//v3KLFVBP70Z4ufbib5SXxte9PD8q0kuyF+o7aChQZtsRVOANsk23dXyS9hF+ZpDHE647r2xccdyknJD7FDKFsLj3CuhVQsiX4jCixM4fPeP68jg5KaFBJ8YNn+gknM2mz2bfROzRdQTKuOu38L0P5v4GvcFk7v2ySaWk2E5KB6Hpao37JAGXQC1dVZcEL1x1B/Sqx1PkKFqtIP4jKlDrzhME1A6nnPjsT2ycg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(2906002)(52536014)(5660300002)(33656002)(8936002)(4744005)(66556008)(54906003)(64756008)(66946007)(83380400001)(66446008)(66476007)(55016002)(76116006)(86362001)(110136005)(9686003)(6506007)(82960400001)(82950400001)(71200400001)(478600001)(186003)(4326008)(8990500004)(8676002)(316002)(7696005)(10290500003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nm6q+YZCHobW0DJKYz0rDU/JehXPt7oPvsf2r3RPdnl+uKcaD/MSaWoGYw7HH1WpwVtCDPmBYQPF1a4RaVC80d0HuZVd88FFbziTVoY6QyW4+UpCPmFSuDyUjBdqrmojpCYUC6G6Zg9Ut++a/Nb21spWBL0L4Pd4veFVqlC6S1SerJP4moFMxpXn7JBPcIec0ZxEY348HfyXHk9QhxBkh8Dw2aFvUahV2UJ6JJngayxlW3Nc1IB1uDeo/fQYOtNxnV1yLigyPg+G44fYHYi2LN83n+jX7JZgSOgNGMURX0DGeZCj3sRd4MxowZZ4jZUXqG4PvwvRxyMVTIAeNqlozIvNTm6xJUvkMZVY3VQy3PWMMUoGDybgmSMyEc6arkjpYoCeKExQLl/cDS4jX54ciiBWA+Z2EPlAEPzY26yyqIoy9cD4W9yjU+pVj35ejK2OZWo3Xss/P83j9bJ0J38Xivot4aB6bPrV6vCPocOdYZAP/U4Sb1YaRz+CkTNzDA2j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b03e43-6572-4e15-c41f-08d8139c20a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:27:35.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOAfOfzySkwQp/Im/AvJi7n3eFGsx3aD5R9UDU6CXn5hFDZWlI+Milr0qB0WmAkp82i3Sy+pjIeozrT52DSD9KqarOvC4LaTv2p6/M551c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ju=
ne 17, 2020 9:47 AM
>=20
> A slight improvement in readability, and this does also remove one
> memory access when NR_CPUS =3D=3D 1!  ;-)
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c3205f40d1415..452c14c656e2a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1702,7 +1702,7 @@ static ssize_t target_cpu_store(struct vmbus_channe=
l *channel,
>  	/* No CPUs should come up or down during this. */
>  	cpus_read_lock();
>=20
> -	if (!cpumask_test_cpu(target_cpu, cpu_online_mask)) {
> +	if (!cpu_online(target_cpu)) {
>  		cpus_read_unlock();
>  		return -EINVAL;
>  	}
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

