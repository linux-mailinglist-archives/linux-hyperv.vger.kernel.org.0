Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6D1C8F5A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEGObO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 10:31:14 -0400
Received: from mail-mw2nam12on2095.outbound.protection.outlook.com ([40.107.244.95]:63553
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728871AbgEGOap (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 10:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrdz3oahrHUkV8WQxPJkocLIz+szEqwmuiYKQkc+GJjmXUk5FR3NOoztrV4KAWh/14F4t5UUq4y4mp2J5F1tCajU9H3AK5YvR5gijjbv5+0ROPp2knIws1xVtXvfFH+OAaTeaEcGAXjVfBruZsvsxOoFTh440+ECOdbz1T4BkhVJDgBM5Ll7E3pL08p4WV+sYnzVNEosT3gRz4C9GjSIUpYF5HJ3vFkwYC4U/W4S4VANRwhMle3VJx6W91dyx4f6eKaw2I2tt3cSMTtKa2uTnEHvQE/0Ql3Bmo7/JFolGeMZW6H1lrC/PuAIp6q2wWaEZJy7kGvFKGWFJV6yzWlB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECC0/1jLu4dN7PzyKffoiRoNKjE9oQTOl51rLAsEvgc=;
 b=TMkU2e61eOFjb52Xg2eH7Nl4Guwi/U6iqOHdMDe47W0icMsaTFOjWwXn1SiOGbkYkPZsMim4ErLXbqWkzca2j8SPIWtCvXfjSzn2ihcTmiUbyA6L865h7R19N1KKGeBrRuoNY84Mfat1z17dcAnjyQJZbeN9KcjA/QtC6O635siF6wSz5yruyu1FuFqT/XpQQYsxsM+R43d7h50NQ2X9HrHYpwCC6y1szbXHYfz2tTu7sQr+NdCaBfibOOd47EZ4NQhgKJexBQwjLklLLgzkwOITF00+36laoAX0IhZBDpIdNwqGPll1mGTe9tNPsxWKU024Yk87EuNe36nzial7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECC0/1jLu4dN7PzyKffoiRoNKjE9oQTOl51rLAsEvgc=;
 b=EROMeIjaKC5skPWQP378Tdjm125uEmtFv9REZTFTMyyI8esr7/iM470pUlF4SQquI04j6cQ7lji7Hr0nDp/We8a5UmOVi2hy0ch8nbUwCS0IzVGQC+sDUnWCrNPdrFV5isyLVaeI2Mxb46BLkm+ndS9EUDiWY7ShMeE8p2NpC7M=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.3; Thu, 7 May
 2020 14:30:42 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Thu, 7 May 2020
 14:30:41 +0000
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
Subject: RE: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Topic: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Index: AQHWJCzZDKxRzfjqCkaO48A4c1MHP6icr6Tg
Date:   Thu, 7 May 2020 14:30:41 +0000
Message-ID: <MW2PR2101MB10522E5BE2E487DF9BD3F3A7D7A50@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200507050300.10974-1-weh@microsoft.com>
In-Reply-To: <20200507050300.10974-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-07T14:30:40.3665743Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=128d0214-299f-42fc-b205-0ba9a5ed7641;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf06d9dd-1c77-4364-0a92-08d7f2933898
x-ms-traffictypediagnostic: MWHPR21MB0830:|MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08301AE5BFC5EA8A6E9FBE04D7A50@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRb9uywRiqmdHL+nwvBfiXE/NuMVQsTm72ftw57nTi0ySW2HglVU+xkjkshsCE8NR0ULS8HFAWUx2hfvjRApB3OTVJ2iy587W82nhDQA2lPNVqE/rCpRPPIwgo7rJrXWLrfrXlcGqxhrfPu6bQL2eCEAjzxA4ZLsiUxNwMj8X+pViDX8U1gSr73QEJm9WleffQl+DlIEKW2sFankCP/CJsuw2zpg7aHJ6QrWBkk2XxkqBMrEdCMvyB6om5VWgUdHkxutGpHitm5YQdOkpkHwbo+dsqf3vSSTcb81rS3JBENi8Vo7aU0V1Bukqqqs3pf6QDb97hNMZCgo7hHOkPUkiS9o0pN6MUE64PFhQeX5dGLw8GcmPHx3LCjjnaLvIQJ4dwXO0jlFZJxktOgLETwaoST6P3yYSM1OxoSDNo2e8BegZUeXyk1WgsV86RN4i7nErToqO87P81Jrgmw9F7z2l52SINysMuXg4wM2lBbQu4kihCGvz8253vGN2AUtt3rcHWBPNyebNoXjOblP7CZphS8UNGYSS2g3P5nqtCKP7jg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(33430700001)(9686003)(33440700001)(64756008)(52536014)(8990500004)(6636002)(66946007)(83300400001)(66556008)(83320400001)(83280400001)(83310400001)(83290400001)(66446008)(66476007)(76116006)(5660300002)(33656002)(2906002)(6506007)(316002)(55016002)(8676002)(71200400001)(86362001)(478600001)(186003)(10290500003)(110136005)(8936002)(26005)(7696005)(82960400001)(82950400001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: k97llJtLsLm76cTndl9xipuKekWXD1CUkGObUiS2Dd/1/tCBe2tPdBHZdEqwAIlWsur6/idu6c7/4z48HLzqDeHb6a6H1oYhBRmrn5wpTCNDZsTw2YTFpS8Y/I+h27Q7MUdhS0yqkCOBrdICRLKJi0cjA+pFRXOOO+gqLlN8Lw2UiCMXxtf9cmjckBYvKeDoXuNjmhjfr/EPsLz+2Olq0aPmieHDLHz2Ep3C3wml+c+a+xMbht+xjbrY1B3lj9/KaW4z+WQYdqz9AUWKU/XzA8g4Wq3OUNXCijD4RcS6SJJCfT/bEPk3l4dcw7nD6hOxcPdvwFZoItTyin6FRWvUJ9Tvb8bCdcE937Q0iQEB+ZT+74MLcIw916AgosDIFjONAKF1Gm2XEnmOUZlcKAXp+wBjBqtPI4zhB2w02tozjaxaFztM/w+6vnnmfkEzS3Eyv0KNqaxwJjGvMdAH2SA2XS0yWh3HPS1izLNLsLUZf+kLLj6ITR6wB5I8HpqCnFcRrSClOm+jHjy099qP64o9anCEZ1xdeWCuCs4OWnB6T7kL10LeJwdndI7zN+BY6ZfuZ86SPSjivn1Y+Vu4UpYTBRLJpLG4fsaBNxjMU+0eir+G7MxxYczRu6YjbptWV6B5RE33JolYr1Gnk7367MT7hT6hx/wzgpqovxEWnUHrURGSz3Oh0rlphLc8ID3z2R6Y4SJFVf2bR1343seyK2VCP98IxSlTHqCPgypOgtv4L5fsy3KBr2zv03WJNxzQNm9K3KkhrkcNhFWC21mnTy6b+V2YPco8OTi9kt94vaEwZpY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf06d9dd-1c77-4364-0a92-08d7f2933898
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 14:30:41.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+fRahHVNgSMZfidDL53tY4gIAerbFndOOVfYcbyG5B0ztGfQYjssiRPHqztJ1vl20HOj77/o8/O3TL9NM7WineonSX3fdoutlwa+R3+zbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, May 6, 2020 10:03 PM
>=20
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
>     Bjorn Helgaas
>=20
>  drivers/pci/controller/pci-hyperv.c | 40 +++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e6fac0187722..92092a47d3af 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct hv_pcibus_=
device
> *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>=20
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
> +
>  /**
>   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> +	bool retry =3D true;
>  	int ret;
>=20
> +enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>=20
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 */
> +	if (comp_pkt.completion_status < 0 && retry) {
> +		retry =3D false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated =3D 255;
> +
> +		ret =3D hv_pci_bus_exit(hdev, true);
> +
> +		if (ret =3D=3D 0) {
> +			kfree(pkt);
> +			goto enter_d0_retry;
> +		}
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
> +
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3185,7 +3221,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	return ret;
>  }
>=20
> -static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
>  	struct {
> @@ -3203,7 +3239,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> hibernating)
>  	if (hdev->channel->rescind)
>  		return 0;
>=20
> -	if (!hibernating) {
> +	if (!keep_devs) {
>  		/* Delete any children which might still exist. */
>  		dr =3D kzalloc(sizeof(*dr), GFP_KERNEL);
>  		if (dr && hv_pci_start_relations_work(hbus, dr))
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
