Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D9FD694
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2019 07:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKOGs7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Nov 2019 01:48:59 -0500
Received: from mail-eopbgr1300123.outbound.protection.outlook.com ([40.107.130.123]:6909
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfKOGs7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Nov 2019 01:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0rvx14kj/cKrp+qe0L2SN92XoqutpzDlCri/axHhAWPIimcP2ooFhcDmqvWA0zA4kJ6T0yuMEhB+uH/NfMFFw6bbA926O7wRBFSIlgolzr5abPVfSLUjrMJQ3I1bvZSCwUgw8K5TNxX3xJsdU0aNv8UsQaDRCm4NoOooGdoteh2TG/MmQGz+unblrzC7atUmbMoBkQxyqqzykEGxCeHS4kk85FB7sVUX91qnY+ysgkQr4fDeT58CZpDnfQ3IM2CbvAAW+zHVzcbHP93GMt1h8QO8ZWmnPFQykoT6n+sGOAPM3+333e8imd6h6K6tphR2h7stDJerAJ9VGLbXK4+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvDrGyCSz67kEAXfX1pcg9tfE9YOMk5a2C33T2CKvP0=;
 b=GRapYtaSNsa3mw6X0DhFg7sQPDuXrjOVOps//I/IgVFRmJ0yEmVQebZV9vU88t2J0wOyBAwp+4wOd0U/u/CFmfmShRhXnfjvEI7sEfVVH8F6tIgxd70W9D2lwLi3xsg+MyRpd62xG8e+a0h9BuEPjG1GyoCCVHpanToBSZ4ddkksykmPKi2RvNPOBfV0UFxR8l7rgqLGYOUyOwxHIv9/2KgO8Cry6gKLMNvqihbzxgGaMWdDjTpbZoIp889rX76MgvBtAkXVSP8ZLMiFxRXQp1ZiHZdro/TJrUIO/fr/juQfocgJfus48rxtYdgvHb2r12LCGuWJafoNsTWXpKu+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvDrGyCSz67kEAXfX1pcg9tfE9YOMk5a2C33T2CKvP0=;
 b=BJPm96IXmxzPj6Tl7Yg+W318XB6a8JcxeICntj+QqffzK/7vAXdZg0i3nU736G9RmRQfEJpGNq2v3bIMCjKkkgmlM538QaULTjaPVecI48goR/BHs5PONpITbAhlpMnd0HkkgcbCWARwgLOE1ZttSC0h6pBBNpHpE0vNv4ZTk+M=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.8; Fri, 15 Nov 2019 06:48:46 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2474.010; Fri, 15 Nov 2019
 06:48:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "Ganapatrao.Kulkarni@cavium.com" <Ganapatrao.Kulkarni@cavium.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "josephl@nvidia.com" <josephl@nvidia.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVmb9TAIfD7Ra2tkqgwSg/PXh9y6eLwmaQ
Date:   Fri, 15 Nov 2019 06:48:45 +0000
Message-ID: <PU1P153MB0169807BF9CE60FC3CA51B31BF700@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-15T06:48:42.1892075Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=190e6afc-81e3-4faf-aab4-b7e2d8190add;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:4883:732d:5e46:8ac9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ac148ec-95be-4a88-9d27-08d76997dcd7
x-ms-traffictypediagnostic: PU1P153MB0169:|PU1P153MB0169:|PU1P153MB0169:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0169336735E76F6B8E22FC79BF700@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(446003)(6116002)(8936002)(186003)(6436002)(5660300002)(2906002)(46003)(229853002)(256004)(6506007)(4744005)(14454004)(102836004)(76176011)(22452003)(86362001)(7416002)(74316002)(305945005)(7736002)(25786009)(316002)(110136005)(2201001)(478600001)(99286004)(10290500003)(81166006)(33656002)(8676002)(81156014)(7696005)(10090500001)(476003)(71190400001)(71200400001)(486006)(2501003)(6246003)(1511001)(11346002)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(76116006)(8990500004)(55016002)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0169;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i301r3WHNFOpVX1I0c3OGMvpBuQqT5Jyl6MpKT5pN4eSU5Nx1qX+G4ZeQRb0foyygUdVMI1jKKy770zVc4gLDhHFnYYrK13H2yo3DRRe4CFBVjwhl32cjRMJR33i4Ub7kWjRoFdPmwzR9pH+q8gylndCqqaR2+iILWDuHJwqkQT2axswxMPZ2hUUGjq/ETyt73L57b1td0QSTWeFb12sGEFTfI9iJ6Sot7oQOUi2LdcdZZTDB9w1qK+SyaANuZkivf6Px1iqo6HQ4ZvF9JCns38qbbR05a+h2Ij6s8w8UuYZUicMOIoqptvMrSioDP6guWjfo1bypMPacFw8VyZbJcA9ffcpXMPPQ4VtrYF70i2FuWxHkQvPKIzygLeywJFFDyFv9i0jgiA1EKv3m0d+mTsHQQn1HnxSW3Iq/DVlSMOQdwAh5YuUOYPojv3CCbhx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac148ec-95be-4a88-9d27-08d76997dcd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 06:48:45.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BCLbe+mNHdMUZUjn+8FunJ1lcguqmFTxOOtyPVd/kcXOv1QF6u6YpyASMylvuR+NJFGPJEyPtU7wBBQ05lsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0169
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, November 12, 2019 5:12 PM
> ...
> @@ -190,14 +278,20 @@ void hv_stimer_free(void)
>  void hv_stimer_global_cleanup(void)
>  {
>  	int	cpu;
>  ...
> +	/*
> +	 * hv_stime_legacy_cleanup() will stop the stimer if Direct
> +	 * Mode is not enabled, and fallback to the LAPIC timer.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		hv_stimer_legacy_cleanup(cpu);
>  	}
> +
> +	/*
> +	 * If Direct Mode is enabled, the cpuhp teardown callback
> +	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
> +	 * stimers.
> +	 */
>  	hv_stimer_free();
>  }

In the case of direct_mode_enabled =3D=3D true: When hv_vmbus unloads,
vmbus_exit() -> hv_stimer_global_cleanup() -> hv_stimer_free() ->
cpuhp_remove_state() disables the direct mode timers.

This does not look symmetric since hv_stimer_alloc() is called before
hv_vmbus loads, but I suppose this is not a real issue because hv_vmbus
should never unload in practice. :-)

Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>

