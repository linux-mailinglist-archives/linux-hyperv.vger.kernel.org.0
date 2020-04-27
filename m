Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037D61B94F4
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 03:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgD0Bav (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Apr 2020 21:30:51 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:52549
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgD0Bav (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Apr 2020 21:30:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRIEYz2Zl/8TCxzix8ph9kUhQ1Ok6YHM8z+JT4PD0/NL1PPUrQbw79HqzWwgj5oLFVpjJUNQjNjyzQwnCjUqkpMvWOYSrm8AqHvGnDlg6OWb2RobQGt1azY8dpKCnGmQqHEZMTmjQ91b35/MopdBz0qHWh4ZOjTNmpzEogaCBK5HA5vr8rYiAomqF/5yYecbjZF7pQrTjhgkk28gbTSBYRIK3HA8V6fnSJQVzkE6OMa4P+GXHxlxzJZrJXSRZlHlk/BfwwWHa9o+GjXLfVrux7XUU+RYhrAN+r9jLZ9NPz/UZcLa7PKRXY06wW+EVxUTd1WP03L+l3zFblAryHD2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KlVgls7mQBl21xmNcaiSFxN+Q8k0FQscSo25zoAPig=;
 b=BPcQ4cBf5VLyZzyqyF+glP04VAo+ruDrpczu6BSAnyhco7V3JH/K4beXLU07BUBGymQQ6UdFnlm6TapI8eVVtgdeXNjQyIeumspIzy26j5ZEdPvIioRBUlHj1MVlYhGaCngHRS1jrGLSyvOV27jNDh8R8yYnSt2zGaRijx+wbR4I6ksKgJba9A9Qy9yvNPiZgov/Txvq3I4CRblBv5Y4eKyh8PlpFH6lN16Me4XBtEjJL2L+Q1JUeBLaGFFKUpyWiBRiDKtkcEtFFFbPDqYWrGm/qXbsQyKwQJuUNPHCYc6RDa/vKWT5NjJRbBEZPtG8+pb2hL2l8nFYqzmGu90IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KlVgls7mQBl21xmNcaiSFxN+Q8k0FQscSo25zoAPig=;
 b=W87/CutOMMZVxiK0azgfAvkV/zXFiEjlhmCzQPYHy61qwINJc1YIw5BbXfDcJIFHHMoWM+GYntREPP4xlZpDppJN4JtFJ6dRf5Hh8eGfeMuq6jF70d8IdUT7Hw2nK03L9K5YkRY3vT/xYzfSj6/QLfrMBX9qMuZ1xQ0RozHoDI0=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0162.APCP153.PROD.OUTLOOK.COM (2603:1096:203:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.3; Mon, 27 Apr
 2020 01:30:46 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2979.003; Mon, 27 Apr 2020
 01:30:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
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
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AdYcMgJHryrU7gmlQyiwFGNu7UeS/g==
Date:   Mon, 27 Apr 2020 01:30:45 +0000
Message-ID: <HK0P153MB02735AD2E3CD36271AED1527BFAF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-27T01:30:43.7737160Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0228ed3-54f4-4c22-8c18-610ea6f4dab3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:39c4:9d02:a54c:22b3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf3af2a9-edb4-4c40-c9b1-08d7ea4a9c0c
x-ms-traffictypediagnostic: HK0P153MB0162:|HK0P153MB0162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB016224E66A58D127AC2E5EC4BFAF0@HK0P153MB0162.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZlsibC9LO2ralGz9iT+segVZTDsisyQWAfN5gk/1zAAnCnMNl3hZu2v5uLPqwVCiifZueArrKRzyLoLe5Fs4+c/Hk3H0s9SJ8VzOxeOLKAFfu3Crd7NBHFBU7Lkpji/Szh+RyPkS3l+p2gX5kPOxF045f/oUR0IMJ7Rw7nXCVCVUb20xIXAJeeeD0CXWuu1mRQxZXyMJ90xx9Ao84Byc/KevtrFHogZeg9XRDuzSZlBN6cXvL4O+Zfuh/f5FmOLULsEFURaRsRws2bJc7ASlgdfIHy8ub8fhbVbXJdNEpmtXS5y1Y8s2mq1ikRKOwFhZt3xEZ0suQ9TRoIHbBLuYJ/1SzVhXelnWMuGNzxhl0knnnhWpZaAbHZgewSq3d7QViidaoi4/46oCvkkeU5pKEmcv9/pdQnAuSUbirtxK7Hb+2GuF0ykxSuOruGTy89Mc4awyg51AKxwC+nZ6yt/BTtqryrySe1L6DNUV4EPHBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(186003)(6636002)(10290500003)(71200400001)(55016002)(8990500004)(5660300002)(9686003)(110136005)(478600001)(8676002)(86362001)(66556008)(82960400001)(82950400001)(66446008)(64756008)(66476007)(52536014)(76116006)(66946007)(6506007)(53546011)(7696005)(8936002)(316002)(2906002)(33656002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: prPHT2t2+BkDiy2YHLv02YYMp4zzdQWR5GuVVSILiDaMiiWy3Zqlim+09x1i0VORSQ6R4mn4f1CH38UoNJGsZndfm7Zx09CrtNp59ZaEiRSE0Y19O/Nq5aTZvGKKFz4VItbDf2a0BCX6kGp/kjjydSzHK2K0JYIG43q8o5GuKBUJGoEytDIP3AKR8JgQYajmDWfzscEtsZVBvR2yhWkeXLS2YEY/l/CJWEItNyGiisX+vNCnMVAUjH4vdt9mJbfPchVwBO+KUlSuECF8IbHuHgJUfR6fO0rG4yreg3T+XRHJg/xz6FjyXkr0NF/weOOGUHVJ1WRgctCBStDMmt64gBW0la251clWPJA2XTzp/TnLGiXjB98zyW9DUFnl0JFwsFP94gCizWqGsQIKlxRFeHTYhrYTFM219NjA+UPmz9tpm9722zthPAMmGkBJf5E7L39zeR8QZmuypSnJvXKXrIg9xxqPWoxYh5IxW1zyCSQHqI+68WwBgAS91bkSXszxLzzAdrKwZ55mayh4ZOyG7FoXfiT+n+3RTLsVM9bV+uWa61dlJLjWSiWNic3iPikwRdqN62uIOXQCIVIvazmY0TIodWfIcTjkdJ15KNKYJfmvmVFud4iqwG+N89EFuhiDfePwUFHScxmc2rnA46a+hKLHMynz7XwNZvLZD1oFO3mz/WfsPMkcka5mQJ/phIL2UlwRb3FI54lJ3KzGSiQfr/BFsMEwIIPYEA7FRnYuMtx9nCn+5ZKYpDGNMLZZfY7V8PXypRFXjLv5QeVk8yuCRgvEFGIBpQjwYbvZuBykArjep5ZZyrSChT76Dgrlb9oMrk8VVesMABhPce6NEvRqmzdVfRtLjZ5fO6dtI3IB3Xs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3af2a9-edb4-4c40-c9b1-08d7ea4a9c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 01:30:45.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ep3dBlGTurfSEsM661W97VI4MwAMy0JDlmYipSvenPfiGd/Jj7E+QRIR+aFGN3vxiMXuOelnISPDMnS7es8fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0162
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Hu <weh@microsoft.com>
> Sent: Sunday, April 26, 2020 6:25 AM
> Subject: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first a=
ttempt
> failed with invalid device state 0xC0000184.

The title looks too long. :-)
Ideally it should be shorter than 75 chars. I suggest the part=20
"with invalid device state 0xC0000184. " should be removed.

> +#define STATUS_INVALID_DEVICE_STATE		0xC0000184
> +
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating);

Should we change the name of the parameter 'hibernating'?

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
> +
> +		/*
> +		 * In certain case (Kdump) the pci device of interest was
> +		 * not cleanly shut down and resource is still held on host
> +		 * side, the host could return STATUS_INVALID_DEVICE_STATE.
> +		 * We need to explicitly request host to release the resource
> +		 * and try to enter D0 again.
> +		 */
> +		if (comp_pkt.completion_status =3D=3D STATUS_INVALID_DEVICE_STATE
> &&
> +		    retry) {

Maybe it's better to just retry for any error in comp_pkt.completion_status=
?
Just in case the host returns a slightly different error code in future.

Thanks,
-- Dexuan
