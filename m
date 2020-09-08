Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A912621A8
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIHVFi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 17:05:38 -0400
Received: from mail-dm6nam11on2114.outbound.protection.outlook.com ([40.107.223.114]:42753
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728197AbgIHVFh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 17:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P19edhO0OuW8noVX1tud91X8O32ePvWBs/RSBV7k8yt636AsHCDXr21udTRzlTOgUDAgiHmJgMeLYOp/wx99x+QaP+POdoWXus3pPUzk34qV7/n/WhXnt4oeg1Q5KL3S0Czpw2zzKCI7wZV7OwhkmJ1ysUo0rFqw3bBym1x+E9rLHxje6lXhAqDoW/vJcNT4DUDaPXU2UKuCUWpRxyCcRNwkZsFKlsKeVTVxmnoYbcIwfIUh6K0DUHk/bWrcR0KbDaC549MpY9lQr7dXCYjeeT7kpJbsF08ke4BELc/nSYs6yLDm5851TD+U8GvtAcEoLNCFxcCHGjezGSFx4ko2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWHlhjH6w/iTHJiVheEJwP1KwHrUuTVphtqBigu/f1g=;
 b=mzSIAt3ZjUqYk8TNhdt3eBI+Yzd2PH9+270LzerDl4nzX0dg80vCQRp0MpxBrSCySu8DKerQZOa+A4gVbwmWb6DNfKNcHyj7ZlvGtrZWq192CPQ1EWZ9mrujei6oMyW+HSg3MAGvSxTzdkgRnGJEJog+Nq5nfxuJ3jOy0xeG4ULSPCx9SdcLNQnTEuY1eXLVtR75h0uu7stXaoRoreo/nrKI6S2khMg+kosAeMEfsP0c2NpTqWMi573vPQ79exyeRmdEnwKieY+X8VL2Un2Haw0Uht/4AN4KhUUmzQNaS0P5b33s1VWtqp2rOMPfYUiB+nvEuS45oyxqzYLhvl/s1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWHlhjH6w/iTHJiVheEJwP1KwHrUuTVphtqBigu/f1g=;
 b=VtO680JKADHkZgdn2MkjWKUoU7/ginLqNMOE7cFpO40Kfe3N7O/v7MckJSqUDKoR70APeKxMGQcRxySM0x1jz6UU5pUE8MHcngV8e0cLqYljVMX3RDHcaFTqLpdpjJ8RUkKE4l6b5Ob8sXHCtFpiVSvm3ZKalHkOceIkY8Vy6p0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1801.namprd21.prod.outlook.com (2603:10b6:302:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.4; Tue, 8 Sep
 2020 21:05:34 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%5]) with mapi id 15.20.3391.004; Tue, 8 Sep 2020
 21:05:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: hibernation: do not hang forever in
 vmbus_bus_resume()
Thread-Topic: [PATCH] Drivers: hv: vmbus: hibernation: do not hang forever in
 vmbus_bus_resume()
Thread-Index: AQHWgzAke73uaFTcbE6462qO1rlMYalfQJjw
Date:   Tue, 8 Sep 2020 21:05:34 +0000
Message-ID: <MW2PR2101MB1052BE3C25E87FE1CA5BA0F8D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200905025555.45614-1-decui@microsoft.com>
In-Reply-To: <20200905025555.45614-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-08T21:05:32Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fc517d48-880d-4b5b-af8b-944f44fef7cb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aec682e-cce4-4491-8e3b-08d8543aed86
x-ms-traffictypediagnostic: MW2PR2101MB1801:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1801E4A8DC9B594576F83850D7290@MW2PR2101MB1801.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bHkRdDl5RSxt5YTsWHVNpoUS7mbcLQVmYtQP82n80/gTCPyD3m5QNtH3Ux5lmUrNmPSLsVsSgpl1xNjbWCtHgPq9wLaT3y6kUANlPr9W5TvL/9oXu0MwXu/LGsJdXSI9XG/N3yNceUtW/Vg80gfAB6Sm2/J7y8Neyab6U9Yq8iWKcguPbeK2QJsJKyL9S+pNR2VTPkKrLQSNXgEpVZwjJBVfk/iHjhqt27+rCy5dC8b68ma+/cdMO7tPe3029Y2RhNJIraX/fOg4K7+p0ZaTtZXZngFTX144SPnULAvX/n4790gd3X94jbOs36G3MlrhaSLmdP0OtR1ZYjlUgxOdSrnCr2TzRmdmsm1N1xxoaYn5AbN+11bbAiiFkTvRZwE6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(26005)(9686003)(82950400001)(82960400001)(55016002)(52536014)(8990500004)(10290500003)(5660300002)(110136005)(8936002)(83380400001)(8676002)(64756008)(2906002)(66556008)(66446008)(76116006)(71200400001)(66946007)(66476007)(33656002)(478600001)(6506007)(86362001)(186003)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9vkB4J+YufrZwHPiXy/83ocvGFJGcupA4tyKT9KtVuLOJViyDEh9qyH47KHxBN/v5TiQxzME8SXu5nFuaAc3Tpxq4RtCJwxTYfy0Tt9byG0T/dk7GVXXPgFht2jneO6raHFPcv/MANIhSUsRs6utA7ImNJiw7eCFw8ay9qhh2M8S1t/sbRb5u2ZT3947yEjbxY3XJE7HytaG5pz4TszqaHP0+F6M5Nn8/AJcPZZJAVVqE59QDzA1H0U4cKWBRhi5/yDpgEEyrOqKms0uTVvajeIkbNLS7Q4TLpmfEF+MCyt/zTHeh28cFJe23PsM3LDfLqMfFTsjPZ+kJ9l7IAzdcQQZpqXim4Oo5Fdze/g4iltT21HR2g6MkmRUlAVv31gkNwIJGvxmrczsf/K3vHMEYXp1btNDE4SG3R0j/yoCD84AMFqbSJThQxtHjQiIQAhMQ1km+Mx5JwdjvlTR362lCd59EdiS3aKTisLMw/Qgld2WooKPkoIrGyoIcDsPwFyhVrxCM7Q/2fb5kBlv1VhiV4GwBrSOwzPRiJZhrDiyQSKzRYuoTXOV5dEh2EH38SFOVB5Az6DPJsrCL2ThkxT7RwJAsEFNS5+D2l4ER4NVirxcaYYKCOWz0Fe8uhzXvv7lg6KTr7aUlCItBYKPm+hx0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aec682e-cce4-4491-8e3b-08d8543aed86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 21:05:34.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZML0/b2IFVxsRA5qO/JxEhJ80m7sfGtNg5xeRYqQJbWOW1OIhCEDEQhRqjpKGHjFE6+oEMkWQs21oM9W0bUbRCBsoGoe+nt49iBsI/IhDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1801
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, September 4, 2020 7:56=
 PM
>=20
> After we Stop and later Start a VM that uses Accelerated Networking (NIC
> SR-IOV), currently the VF vmbus device's Instance GUID can change, so aft=
er
> vmbus_bus_resume() -> vmbus_request_offers(), vmbus_onoffer() can not fin=
d
> the original vmbus channel of the VF, and hence we can't complete()
> vmbus_connection.ready_for_resume_event in check_ready_for_resume_event()=
,
> and the VM hangs in vmbus_bus_resume() forever.
>=20
> Fix the issue by adding a timeout, so the resuming can still succeed, and
> the saved state is not lost, and according to my test, the user can disab=
le
> Accelerated Networking and then will be able to SSH into the VM for
> further recovery. Also prevent the VM in question from suspending again.
>=20
> The host will be fixed so in future the Instance GUID will stay the same
> across hibernation.
>=20
> Fixes: d8bd2d442bb2 ("Drivers: hv: vmbus: Resume after fixing up old prim=
ary channels")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 910b6e90866c..946d0aba101f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2382,7 +2382,10 @@ static int vmbus_bus_suspend(struct device *dev)
>  	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
>  		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
>=20
> -	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) !=3D 0);
> +	if (atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) !=3D 0) {
> +		pr_err("Can not suspend due to a previous failed resuming\n");
> +		return -EBUSY;
> +	}
>=20
>  	mutex_lock(&vmbus_connection.channel_mutex);
>=20
> @@ -2456,7 +2459,9 @@ static int vmbus_bus_resume(struct device *dev)
>=20
>  	vmbus_request_offers();
>=20
> -	wait_for_completion(&vmbus_connection.ready_for_resume_event);
> +	if (wait_for_completion_timeout(
> +		&vmbus_connection.ready_for_resume_event, 10 * HZ) =3D=3D 0)
> +		pr_err("Some vmbus device is missing after suspending?\n");
>=20
>  	/* Reset the event for the next suspend. */
>  	reinit_completion(&vmbus_connection.ready_for_suspend_event);
> --
> 2.19.1

