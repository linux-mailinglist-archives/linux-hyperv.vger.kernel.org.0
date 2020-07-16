Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A821222831
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jul 2020 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgGPQWY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jul 2020 12:22:24 -0400
Received: from mail-dm6nam12on2122.outbound.protection.outlook.com ([40.107.243.122]:15393
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbgGPQWX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jul 2020 12:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIgLU7S1faUrpxgWj+fdpRSEvQips+ULSSa1nY0FekRb1pwMVdUzKYhzj1WicXbfPB5kRL3iQMvzAxQbTwmEhqyBKUEGUUY7csIBCZ1DhQsUsH5MszJ70ZENRvJ/tAKTCet/nUxNrqrgXw4qWI+lzPpbol5qJCu8ldX7PlORnhNIvdGudHfqBoAzd+7o7OSdVm5o3UU6h3yOp3CO37WlbwQk6TjMZob/utZEMGtnZfWWkUJXWW/gQALbNJsfdEMFt2yAG+oA0fQkNtYBHfGUj3yk0flkUnEQXM6Snl0AWyxdBbDATlxqFJNI0Kck9XSZEowhzlzocQbkICkN/UEkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iE1woUeDz10TjeznLyj39xoEcxh/LUdqRkvX00AkoQ=;
 b=fgtUcjLHe3pjBht/6jWhr6ugtlypxc5Zr/gcPYojescWkkWNdstPMtcLLOnGrksSI4QFJ/S/Lov5nlL7W5MCzNu7ZNyQ/APtUqH7pBBc2HJI/0/t1svLzoPa1QStQBQNNv8/Pi8X84dCJjuhiheqkqq2zMlOknDEQBNKYwvIL+N6OsxeJdO52QVifCn4ngr5LWAiRw9Yx9O4oYR/t0DR+tc7ABzxRBgw/T799BSCnza5hSeiwMXuehLGRdD+mS/z2dlG1xTnKLVdS7JQCoonW2OXdPqrXPG8wlDbTaIX6E5SJDeMP5jL1C73eNe7Ns/ExI92XvS7IfXTzFq18Ir29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iE1woUeDz10TjeznLyj39xoEcxh/LUdqRkvX00AkoQ=;
 b=dTzOiE8T3E1rJm+5YBPGrSEBIdHnoluDtE5weRSWH3tlHeLKRu8kN3OtVM0LoycWALXAh6docURjetUIPXKxrtyHfAQZsGtfzxAugYJko9T1yi5IHWfd1Kp2BDWpNqHxOSkRNnLyP9BUk1+JUZYI0GDMbDzijufTs1MfJmaTprY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR2101MB0809.namprd21.prod.outlook.com (2603:10b6:301:76::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.7; Thu, 16 Jul
 2020 16:22:20 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3195.020; Thu, 16 Jul 2020
 16:22:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Topic: [PATCH] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Index: AQHWW4kKgxCSbCk8eUivc9mLWq7fwqkKYqeg
Date:   Thu, 16 Jul 2020 16:22:19 +0000
Message-ID: <MW2PR2101MB10525DB04278B3042053FD83D77F0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200716155128.2038-1-weh@microsoft.com>
In-Reply-To: <20200716155128.2038-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-16T16:22:18Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d00d051-0925-43d1-817c-c62ab6ab7275;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36108cd9-a141-4d36-35a5-08d829a469f8
x-ms-traffictypediagnostic: MWHPR2101MB0809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB080936BE1A40DEF3239DA02FD77F0@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6J4vM4S/VeppVxYN+yjxc5NUnzeTDhIfdh+7mjHaZAIFF/gSqNyGlxNnt+SCr9B0rICHsT/mcVGZJwivFSb9//hjCo/Q+g2j8RXqjii5a1x235FPoIFCrLFyBMbl5DuPGgVGsl3lnPfGuPkqGH5nE93YJNry+g+qJWz2dtQvF3Q4eK9V+NyPv4X+/ttwmhqmJRGWyETR4UYPJf/b5f8WsDWCiryRGqNT/TqcKKtNuY0bW4D4A1kD8a/UfidhmsXErkDMboprPqg65kGFrB/VPRIDFl/U0pqvqp4xl3XzGO6L8kPiFYJ7aXpiBdwXl/tgzoH42k6vasK6e1gjPe1/dSpNL9IsDue//guji2rVVJUp3ZyVaLoynj2SXr6Ww/H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(186003)(26005)(8936002)(7696005)(52536014)(33656002)(5660300002)(82950400001)(83380400001)(9686003)(8676002)(55016002)(82960400001)(8990500004)(6506007)(10290500003)(71200400001)(6636002)(76116006)(66446008)(66946007)(64756008)(86362001)(66476007)(66556008)(2906002)(316002)(478600001)(110136005)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KHG8ZJA/lZzdYiLrr7LkwcdGKpoMXnHedxF2bF4NdNrGE+/qrkfZhoE/dK9IxIqA0ZLfNl5zjsivq11rZjcu3L9oTMlEcPlAXfxTXNKodZ2BMsPtSicuh9jf8bzNPzG1NKXql3tQvjwl3H4E7LzVErNLJSjJRIwVEW9KtSlgU2ygfYh1/8ZYeN8TAfznPesXQsO8rzi8B1kLXAfeK+uRChbeMizJlpRrBo+AEOutCnlrBCKWoQPnotrQSJfkcv8XQ7nCKvog41rvHoKH2/93OH1GIYuEEjNcc591wuVVjiS8M7Ss8rMDODnpJpX+Lf08lgK4o/r9v4Gln0djghldqK3OrYpinFw9SomWHGaZ0HpOYPtYnQ7GhjAHaQ2PEYSHGFhrd5Qs9pgZEGrQ3KUQJUgPQkoeFIJdS0ZcXSNKuDkW6OpEvaLthBw8VpQuNUyIjWG6VOMxNWTnbnfEkcouJ/lg5SwyGPs69Q1PwUVShfls02ZPx2cqHHWGKAOfx8X9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36108cd9-a141-4d36-35a5-08d829a469f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 16:22:20.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OI36+rw7R49MgxrHz2rBYk55hDQc7O+3gVfTkLc5UqeZKCOLbMGlXVTWEMuRccY9Rd2df1e8kTw3ca0INEpD5k+dekjMx0zce3jOzikyaSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Thursday, July 16, 2020 8:51 AM
>=20
> Kdump could fail sometime on HyperV guest over Accerlated Network
> interface. This is because the retry in hv_pci_enter_d0() relies on
> an asynchronous host event to arrive guest before calling
> hv_send_resources_allocated(). This fixes the problem by moving retry
> to hv_pci_probe(), removing this dependence and making the calling
> sequence synchronous.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>

I'd suggest adding a "Fixes:" tag referencing commit c81992e7f4aa.

Otherwise,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 66 ++++++++++++++---------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index bf40ff09c99d..738ee30f3334 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2759,10 +2759,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	bool retry =3D true;
>  	int ret;
>=20
> -enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2789,38 +2787,6 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>=20
> -	/*
> -	 * In certain case (Kdump) the pci device of interest was
> -	 * not cleanly shut down and resource is still held on host
> -	 * side, the host could return invalid device status.
> -	 * We need to explicitly request host to release the resource
> -	 * and try to enter D0 again.
> -	 */
> -	if (comp_pkt.completion_status < 0 && retry) {
> -		retry =3D false;
> -
> -		dev_err(&hdev->device, "Retrying D0 Entry\n");
> -
> -		/*
> -		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> -		 * to free up resources of its child devices.
> -		 * In the kdump kernel we need to set the
> -		 * wslot_res_allocated to 255 so it scans all child
> -		 * devices to release resources allocated in the
> -		 * normal kernel before panic happened.
> -		 */
> -		hbus->wslot_res_allocated =3D 255;
> -
> -		ret =3D hv_pci_bus_exit(hdev, true);
> -
> -		if (ret =3D=3D 0) {
> -			kfree(pkt);
> -			goto enter_d0_retry;
> -		}
> -		dev_err(&hdev->device,
> -			"Retrying D0 failed with ret %d\n", ret);
> -	}
> -
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3058,6 +3024,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	u16 dom_req, dom;
>  	char *name;
> +	bool enter_d0_retry =3D true;
>  	int ret;
>=20
>  	/*
> @@ -3178,11 +3145,42 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (ret)
>  		goto free_fwnode;
>=20
> +retry:
>  	ret =3D hv_pci_query_relations(hdev);
>  	if (ret)
>  		goto free_irq_domain;
>=20
>  	ret =3D hv_pci_enter_d0(hdev);
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 * The retry should start from hv_pci_query_relations() call.
> +	 */
> +	if (ret =3D=3D -EPROTO && enter_d0_retry) {
> +		enter_d0_retry =3D false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resources_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated =3D 255;
> +		ret =3D hv_pci_bus_exit(hdev, true);
> +
> +		if (ret =3D=3D 0)
> +			goto retry;
> +
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
>  	if (ret)
>  		goto free_irq_domain;
>=20
> --
> 2.20.1

