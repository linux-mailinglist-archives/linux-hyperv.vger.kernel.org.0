Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB91120FBAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgF3SYv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 14:24:51 -0400
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com ([40.107.243.92]:17207
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729953AbgF3SYu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 14:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0nqLE+Sb7Zj7bSE5yKsORtoMdXjiab9tu51AT0LSnxXT0vmdWAylsRIp9pPT02ohw7F0r1U3h03DskxBVu8l/ujv7PRbJ/I5fjxZMWRyT8RifGLdhwDZ86F9UuS72vYCuizMetzu6+vqMQmOfK9J7dcr6oSkvZppgfRlEzXQOxByBR/x4g+EBUOO3Di1snqssHQutF3TrN5c/Falsq05828414nGnGLhI1h/+aDjzeQ4PCX0/KSevyqFpQVBffXvl6dQM0gj4GH3zN5D2WFZw7fFcIE5iv0WHwYqSrztDB0hi7NSgHxC1yWuOM7nEtRtS3bmWzkwc2wd6XhZLuNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQSdwXpv8qUOLUhvlcQTeSRLJfvcFz8HhGTQ5oX4EoI=;
 b=WAROffuqOD3ns2S2kgGeb/zd9kyhEmNb+sbGs+Wqpq+Mgn2lAjOwrTr2WI8GGyMrkcWTz3YU6WmVyYThcWsYQr5dzzfLZ4IxnrAdhyp9XRhP4PM5YJK28WnM7Ro9XMfcWC5uhuvYt6WVMnnZyOUxX8KwiMU/IpQ6z0z+P07n9gqYpcFT2WoDmZpOz+qYSqekvkgyBcW64AqfLMPWHuz9AFQ/hsOeZH/5Kgm/EcGZBEDtU8IQF07v61QEIPrtwarAKNOlPBYDEsYlZ9CFM/DCcmuUUv8T00KMe8SQbb58kMI3AokA+L+yzn/GX4+s0E+UraNL2zrUgPgi9cAsGDTq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQSdwXpv8qUOLUhvlcQTeSRLJfvcFz8HhGTQ5oX4EoI=;
 b=HlNicZ9TLFxuYHANfx5ii4D0+oQyVXkqKkZptZe3jJsnUlqoj2xR4nv0xiX0Ag7Kl2TSWXITNHI/ShpH9gCBWTB29ITFAbcyH3sOC5fK+fCIR6V5Wfk4hgVDQ2t8uuu5au1ueXnU273sc/5tRM9toUhr+KgpYee4zG1QbKm67Sk=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1003.namprd21.prod.outlook.com (2603:10b6:302:4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.1; Tue, 30 Jun
 2020 18:24:46 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3174.001; Tue, 30 Jun 2020
 18:24:46 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH v3 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v3 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWTvOfjyVJH8tIZEuq2u/CM/7XDqjxd/ZA
Date:   Tue, 30 Jun 2020 18:24:46 +0000
Message-ID: <MW2PR2101MB10525CB82CC45CFD19D7B40DD76F0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200630153200.1537105-1-lkmlabelt@gmail.com>
 <20200630153200.1537105-2-lkmlabelt@gmail.com>
In-Reply-To: <20200630153200.1537105-2-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-30T18:24:43Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3738d099-8dfd-4a63-8a98-00b4f20c6eb7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a14640c8-65a2-41ac-119d-08d81d22de52
x-ms-traffictypediagnostic: MW2PR2101MB1003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1003F20F287E0693FD8E2D7FD76F0@MW2PR2101MB1003.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFrERT4XvbTKd3Qfepp4j8my1cTxaWyWBkqA3LEOVx5qK7DvN6ocCnMBA/U5DYuid1H+fKZ0ucBYJsNXaPdISTUbCvTA2otQY2Nukj5DJRlPNvRp6ilq6BktCOiPdAhcmfmt6Jt7pkuMZ5lGvd3t3EXokv3i0Erf6lKOlTi0evnd3QOjVbRtJD3Uhi1CZS5AQniRp7/RDEoBHjCHaOUw8ShVLuisfwdB9fqShKQ7EdaJQKNmKF/gxAKm+O+cOv7r1SOVu8D72JnCFhCOS8qm1PoaW+tLCs+JBgQRwvK/GLMfKlWMQ6HNhM5Q38lQ1xxseqJmGhhBRQ8gaRnri4mDtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(316002)(83380400001)(186003)(82950400001)(6506007)(26005)(54906003)(8990500004)(71200400001)(9686003)(86362001)(55016002)(110136005)(82960400001)(33656002)(2906002)(10290500003)(8936002)(4326008)(76116006)(107886003)(66556008)(64756008)(66446008)(66476007)(5660300002)(66946007)(478600001)(52536014)(7696005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lbUG9r3Vek2kU9pajJwVDbmh66EWRpvQvhZOVaUUXm9zBqAzpyUUBc0p4U8nby3fE8e14b0f6ykolxxALrT4OHvDSCPgIyd40vUxUiurX1D9WV0twMPSqFqlb0lit31rkT111GVXtljzHjs4ebzuYWSl0PvELxAmnTu5Qz02fmrL+qRVOzMdkUdkiW83nUZTGj44a7lS8yudoLBd1ng3QAd/fRRzrMPYEzONImFUShNndE489uHU73g5sWJJ3wFsFrrZyLmP2j89pG5XoNRHxumjyDYsKbiW4fWd+fh7zGZZOE+LsAt0RDza0C/cix15eQxuM4u+CbUjzTlyJ+p6f3ISbd+wqDUxnD0DhOX+NVVY+csteAztsnPm35d2nefrVxMAIx8dxtHZnVXLN6Ba7mM4kNduaHLnOUGme4jvXP7nrIXuZnvqlxgiTwheFlmixUx/FYSdAFWwpbVYkEF29sgU/kJ4ya3jX3Um1MJn5xHuXpK1h6CAd7cMT8N7Ypin
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14640c8-65a2-41ac-119d-08d81d22de52
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 18:24:46.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gU493LEnqTDq5kNx4D0NdQxfbRkHJIhfQKx69Kq0JBpkP3KUMjq/Objkuh+A1r7HReYFIgwUSRG+pKx06SxYWgDnodlBz0HnwPkvKq6zWQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1003
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Tuesday, June 30, 2020 8:3=
2 AM
>=20
> +
> +/*
> + * vmbus_next_request_id - Returns a new request id. It is also
> + * the index at which the guest memory address is stored.
> + * Uses a spin lock to avoid race conditions.
> + * @rqstor: Pointer to the requestor struct
> + * @rqst_add: Guest memory address to be stored in the array
> + */
> +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
> +{
> +	unsigned long flags;
> +	u64 current_id;
> +
> +	/* Check rqstor has been initialized */
> +	if (!rqstor->size)
> +		return VMBUS_RQST_ERROR;

Conceptually, this check isn't really correct.  If the rqstor structure
hasn't been initialized, then the value of the "size" field is also
uninitialized and hence might or might not be zero.  You would
have to check the rqstor_size field in the channel struct to
correctly determine if the rqstor structure was initialized.

Because the rqstor structure is embedded in the channel struct, and
the channel struct is initialized to all zeroes, this test works.  But
it could break if the rqstor structure was allocated elsewhere
and wasn't initialized to all zeros.

> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +	current_id =3D rqstor->next_request_id;
> +
> +	/* Requestor array is full */
> +	if (current_id >=3D rqstor->size) {
> +		current_id =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	rqstor->next_request_id =3D rqstor->req_arr[current_id];
> +	rqstor->req_arr[current_id] =3D rqst_addr;
> +
> +	/* The already held spin lock provides atomicity */
> +	bitmap_set(rqstor->req_bitmap, current_id, 1);
> +
> +exit:
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	return current_id;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_next_request_id);
> +
> +/*
> + * vmbus_request_addr - Returns the memory address stored at @trans_id
> + * in @rqstor. Uses a spin lock to avoid race conditions.
> + * @rqstor: Pointer to the requestor struct
> + * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
> + * next request id.
> + */
> +u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id)
> +{
> +	unsigned long flags;
> +	u64 req_addr;
> +
> +	/* Check rqstor has been initialized */
> +	if (!rqstor->size)
> +		return VMBUS_RQST_ERROR;

Same problem here.

Michael

> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +
> +	/* Invalid trans_id */
> +	if (trans_id >=3D rqstor->size) {
> +		req_addr =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	/* Invalid trans_id: empty slot */
> +	if (!test_bit(trans_id, rqstor->req_bitmap)) {
> +		req_addr =3D VMBUS_RQST_ERROR;
> +		goto exit;
> +	}
> +
> +	req_addr =3D rqstor->req_arr[trans_id];
> +	rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> +	rqstor->next_request_id =3D trans_id;
> +
> +	/* The already held spin lock provides atomicity */
> +	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> +
> +exit:
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	return req_addr;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_request_addr);
