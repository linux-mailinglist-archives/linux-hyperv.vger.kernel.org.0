Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7D1B94B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgD0AP4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Apr 2020 20:15:56 -0400
Received: from mail-dm6nam10on2090.outbound.protection.outlook.com ([40.107.93.90]:29857
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbgD0APz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Apr 2020 20:15:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehOWcqboWa6MVStqHk35nWzgsKfNG8hDdxYBHbPnhLk7KJSJEE3gJOpicubJpULdvX8a9DfQAoV2sk9ZbwEvNNGqt/c87517b/cDVNkrpgvD1F9c3HWRnXRJayeF7qnOMeFWihb9wVB/hEz78eEeXmZTDJuCZcq7XYWhjBWFQOt9iAde7LFVhByOPLSJP126yoFUP2VspimTsUaX9tJzS7lCymODRdERwIwNWANSRlxeOuZ/HqW4wLO4UuXfdTNduwedeEpR+eKINiO/R58lIgCZ8er7B7qrhL71dQXl/64VXYtBDqdxWHikffsbdvmYevbLDl/1Q9ZeEDlxpfTVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiI9co0T3xNrgk5SJ5G0mGS8v6XQSOXGV06LfBaeTzo=;
 b=QQ68OsSdBbfA4D/RR/ImyYpZsskTaETt2cSG+r3aOXeJEjS56O9C0GdLNVDiVFi1T3k/I1VMBc/moGgWjLa7otq1mBfX3S3uJvjLUaR4TX88KxEu3Q/GXG3QAbyvpjkWjnMQgmgGf9lsp0WtO3YzMoPfxv4WKI43i5RTlMmckSjED8OO4ShDZnck4ImRrCjfI3K5FHiCEsJbvLARUObp+c9LaIT+U1qDmZhlChCmav4gVDhtVnBrMrVqtmwKFZ++sD1rAkeVPxjKtavcr7d30JkkeQnCHtd+0UOUNPq6HsQZ6dkAW0fvZFvAdb9GryjMD+QAnMXorvAJZjAQqBe25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiI9co0T3xNrgk5SJ5G0mGS8v6XQSOXGV06LfBaeTzo=;
 b=NUIIihgaGZJeqc0m/TLrxrcUUp8if8BTjgFY/K1q72RoMlh81V6PXJXoSq0rlJgPgYYywyfdRZ5txXiQbcWBeonv60BmuZF83VhD59qrCPHxnr7AAErYpXuYqeclRkYsftu1Wwiq33txb0ukOg0rTCaf4Wk4uatpxfywr9jBNn0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1067.namprd21.prod.outlook.com (2603:10b6:302:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Mon, 27 Apr
 2020 00:15:51 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2958.001; Mon, 27 Apr 2020
 00:15:50 +0000
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
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AQHWG84m7LFBk05zpkqgxdg/cn42SqiMEvJQ
Date:   Mon, 27 Apr 2020 00:15:50 +0000
Message-ID: <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200426132430.1756-1-weh@microsoft.com>
In-Reply-To: <20200426132430.1756-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-27T00:15:48.8414318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bb357e5-0b89-436f-ac44-3d0a980ed24f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acc07509-c920-42d1-69aa-08d7ea40249a
x-ms-traffictypediagnostic: MW2PR2101MB1067:|MW2PR2101MB1067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10679BBA1148ADCD549F3514D7AF0@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(82950400001)(8676002)(2906002)(66946007)(81156014)(76116006)(33656002)(316002)(9686003)(8936002)(186003)(52536014)(6506007)(64756008)(26005)(478600001)(82960400001)(5660300002)(66446008)(71200400001)(110136005)(66476007)(7696005)(86362001)(55016002)(10290500003)(8990500004)(6636002)(66556008)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fh50B/ePqTDDsfVgjlujF00YYFOqv17vJ/ablRvQW3D9NOzbydutXT6X1ibVX/6+sVNV2tMd5sQaq1DHjz7Si6Mbl5xrHBnQOdlgwOE7UUArEjPUbOsjrkg8LUjgi2m7bfcV5Qp6qFYfrwhuxy4xb/xDmyt9t1ZLs7OCZsV45PazzrwLiXhEiSkl+tDfalfP9bOXZ43SyW4ZGXBtmcS1RyZ9iNd702ansJCfRcRo4OOt4lJgh7uE2yT6JQeMjKbEpdjmnRAB6EJUQ+c+mVfPPuwccQ/WnlqfY0m1yv5+rY8RlapXnzry+36dEiNPdxtKqmhqRlQQJUGmNIKbF49yCynYp0vWuWd8FS4J4lYKe7LCPjB311b2ZjXdMpcwQUDp3LeRkldHdj/0q8hVUYSOB3up1qDbUc++hqSllaHVPgNEe9qgDMw4obsd1QLEv85ZhtpRaWPvcsBEdusDxGGO+jpIXyUnmFiFdYZMYN00FB8=
x-ms-exchange-antispam-messagedata: kMTu20cigae8h73f3Iygw1Qim4JyE+d1JbA0yI+j5aqW56Y/A8bbteXWKfEBZSm2aohcKlyvYrIGg5BnCZg/BgkZWmgLJ5ug1Nb58lGciqkWGQXiSuPUTbY38/4W1cQY3cHC4CksBNX/HX8jO5L57ecWtB/+ZU0lUzkiOf71TcTsHmcTQWfVicfIvElW61qSgjdGCSY79ktxIhm86r3xJR7tEg+aenXXcXQ111y54qRyst65Nj3jb2pbD1wT2jT7MNokReVM9MwXFbO7gjDq0hkmRkEEwV03nwM07Z34UUbfsre+8yTKqC+c4tiSNaA+7+6umVYyRRzCtbN+AP0H9e/4z3SIB3AwIssrE3coGeFuHM7tWJO0TYL+AzQLP5nxr9JyCbCbnU2OD6pjl+CWbC4Njg1hIwIyAppHBp9gV1JSNGfL0aPhLDm3v/EQAR/K1brJb0PmzsaQ7mQxS6sSjQF6sToGKNGUu3t8R4CF1a5DL9dMILB+e62sCpMSBnDBsfLdjGy6hAWZPnnN3/JGUvr7rnc9BuhFUPX72FDDVqPVCJ37DM3xw3JSNNqQZWTP2IGEgFv5YXfZ7iLPGjzUbunhaqPalgzwRrBr9AQgowvIFo5MrXNJEg7EEkWxZrcfhERc9w4zuV0nLvJmyywvhMtVo6s72G7Mz/BCQBWU/s0Xe3WmXFdqNTe5C8iPF64Zgqy6jJNRj9kHjm11J3bz68gPl9UKLhOQfOs4JgTqUDhZbAJOthS+AidOjC3hFdvGoP67KCy5aat/uqAaClXWKmk/kwkhPU/nPS299yIEBpM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc07509-c920-42d1-69aa-08d7ea40249a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 00:15:50.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ivdpi90vCwBl8lveFF0JoD2lzuBhhBkjEIT99RYbWHHAsA0enNvrWtiFtgiDgFZirA1yq5bzO2l0xu74f7DbmGWZ66c38ihHEBt6KXR/JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Sunday, April 26, 2020 6:25 AM
>=20
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state 0xC0000184 returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
>=20
> Also fix the PCI probe failure path to release the PCI device
> resource properly.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 34 ++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e15022ff63e3..eb4781fa058d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2736,6 +2736,10 @@ static void hv_free_config_window(struct hv_pcibus=
_device
> *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>=20
> +#define STATUS_INVALID_DEVICE_STATE		0xC0000184
> +
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating);
> +
>  /**
>   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2748,8 +2752,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
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
> @@ -2780,6 +2786,30 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
>  			comp_pkt.completion_status);

The above error message will be output even if a retry is attempted.
And if the retry succeeds, there's no further message, which could leave an
incorrect impression for someone looking at the boot logs.  If the error me=
ssage
is output, there should be a follow-up message indicating the retry succeed=
ed.=20
Or don't output the above message at all -- output only a message that says
"doing a retry".  This could be accomplished by doing a separate test for
STATUS_INVALID_DEVICE_STATE that is not nested under checking the
completion_status for 0.  Here's a structure that also has the benefit of
reducing the indentation levels:

	if ((comp_pkt.completion_status =3D=3D STATUS_INVALID_DEVICE_STATE) && ret=
ry) {
		retry =3D false;
		dev_err(&hdev->device, "Retrying D0 Entry\n");
		ret =3D hv_pci_bus_exit(hdev, true);
		if (ret =3D=3D 0) {
			kfree(pkt);
			goto enter_do_retry;
		}
		dev_err(&hdev->device, "Retrying D0 Entry failed with %d\n", ret);
	}=20

	if (comp_pkt.completion_status < 0) {
		dev_err(&hdev->device,
			 "PCI Pass-through VSP failed D0 Entry with status %x\n",
			 comp_pkt.completion_status);
		ret =3D -EPROTO;
		goto exit;
	}

> +
> +		/*
> +		 * In certain case (Kdump) the pci device of interest was
> +		 * not cleanly shut down and resource is still held on host
> +		 * side, the host could return STATUS_INVALID_DEVICE_STATE.
> +		 * We need to explicitly request host to release the resource
> +		 * and try to enter D0 again.
> +		 */
> +		if (comp_pkt.completion_status =3D=3D STATUS_INVALID_DEVICE_STATE &&
> +		    retry) {
> +			ret =3D hv_pci_bus_exit(hdev, true);
> +
> +			retry =3D false;
> +
> +			if (ret =3D=3D 0) {
> +				kfree(pkt);
> +				goto enter_d0_retry;
> +			} else {
> +				dev_err(&hdev->device,
> +					"PCI bus D0 exit failed with ret %d\n",
> +					ret);
> +			}
> +		}
> +
>  		ret =3D -EPROTO;
>  		goto exit;
>  	}
> @@ -3136,7 +3166,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  	ret =3D hv_pci_allocate_bridge_windows(hbus);
>  	if (ret)
> -		goto free_irq_domain;
> +		goto exit_d0;
>=20
>  	ret =3D hv_send_resources_allocated(hdev);
>  	if (ret)

The above is good.  But there's another error case that isn't handled
correctly.  If create_root_hv_pci_bus() fails, hv_send_resources_released()
should be called.

Fixing these two error cases should probably go in a separate patch:  One
patch for the retry problem in kdump, and a separate patch for these error
cases.

Michael


> @@ -3154,6 +3184,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
> +exit_d0:
> +	(void) hv_pci_bus_exit(hdev, true);
>  free_irq_domain:
>  	irq_domain_remove(hbus->irq_domain);
>  free_fwnode:
> --
> 2.20.1

