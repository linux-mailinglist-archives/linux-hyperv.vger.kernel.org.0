Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067576D9E9
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjHBVrI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 17:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHBVqm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 17:46:42 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B22D62;
        Wed,  2 Aug 2023 14:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZX1WovSfrjVPqq/8hYN8rQVWBsfVc34CYuecT01aKgOntUd2ihSr1zWQrkZbOXJnMi2Wn1j3hiTSIDYKFCpvdI1mnrdJDxabi/Y8egEif4sOnOB1LpJRV7YMoOb97YN+GmJnIvE4LaE8s1xMVvf2rWX5ubSidUvQGIb3OrzreEzFHWkk3VhGLPpWDSzFNVPveEun1KVoJz82cgl2+bZO/UbWPKx3ZwGsWY3qcpF0QJhJ63bu66dGOLKBVNqada3CkzFXoF0ToFLsuWj8au6GbpxYylU6X+U/TiDHFg0WRRiYrnyYNIkBHx9P1mkXV8ZKgDUtOGL4XYLW8wVT0Fhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP9T6/Q5VMI4CQiUTg5oiGY+ZCUNCU9234K/zLZUrcA=;
 b=dssZKx40ILxKywCZFU8kLmJ7PsnD2m2CLAVURcaWTBzaoEShMYy415+QChk/wskQzo1/Pwf4I7KcKnMtVZm6S8aTGATfr/YpVviJ2ppwoMzcJnAunNpbOkczSOqKsCWh7wI0+ltEH4+CAhdSVfzuTpFJRk2LXFxp8Bi3JrXdBmEHBZcg2MntxkN0yeqCBTJy7ev9U8og83eRZhMLBJZGSLmgH3zobvfqdDe0mRqd5ft2L3Fx7z+0sm8n8IGvbOzUl9h/pkNiU+xCwJ00xapMgUTIUtEHTzuwFyeEnAtKaUUvjfga/H4LhtKgvqT+ZF17ad7VAJZCAjxmBBIdq+Mcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP9T6/Q5VMI4CQiUTg5oiGY+ZCUNCU9234K/zLZUrcA=;
 b=LOeCSA9ZLY+SOHqZy09BQRiy3QMXSf0S3QJxiYHGCLsNvR5x64YizDFdydSPAwdRSeGsm0j/X7bPSXo5m/aURbiQXAIDBQh15Aj3BX+JSsN6jT20b46AK8cIVOlYtIsDwaPpFbHcqTD510OKUvhFi1gmCBpwFAWelyp/BYFFPB0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1536.namprd21.prod.outlook.com (2603:10b6:208:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.8; Wed, 2 Aug
 2023 21:43:54 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 21:43:54 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
Thread-Topic: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
Thread-Index: AQHZtj2TTqsrFtVeJEmFoKyGZAXica/XnY+w
Date:   Wed, 2 Aug 2023 21:43:54 +0000
Message-ID: <BYAPR21MB1688F11EF5924D8D69F97203D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
 <1689330346-5374-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1689330346-5374-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2aa72647-c4ef-4bbc-b80d-0558ac66f7d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T21:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1536:EE_
x-ms-office365-filtering-correlation-id: a16d1617-5533-4aab-f7b7-08db93a1918c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EbDXACKKyVI+aaoGsW0//DRJid9eey0xuORqY610fB0/O4swourSbxeNeL+mo4A97zj29AINPIgEB7lbLUo4/NJji2imAoOU0aNDxaaxH3uINaVOY+CX+85WBX+CYcWYmreBAmE5xvMj9h6lrG/bK9uFlWlADxfX9HHXpA6f1sDJJLpHmmjITo28Nduz8rizWBtAYBpq7E/yTPbH30c0R4ueP7NOKmTDCIIw/mOKrcbLfvMK7z0Q1NwYJdRLFBjMhW/W/Gre3BrY6e+9z5LrbJBbGlG0cT6gFDTOpS/jijTSNHR7wlQQn1w719GM5OVfG9SVTxML/It7UwwPvgWMT+j0noTLXwa5gA/5ma6NqSqYyAiEc/PUhcZuCj2wC8lYy+iHlaFZDMPhqRxhfwviTWlgwL3alm6bjviVYsizADmb+E+gpbLWmorlJ26ffLzXSToVPVeJXiFxu6+s4xgRt6C7j5OvrB10WbHS+dYoM8PEdAKZqZEDLVUtJeZ6qVoTBVFny6rv8AgrXYQTE22KiNd4MJ6xadShNS3UvTFbKhBix7V8+K5r9wgJ464RbFA3mW1mpqX23H7LTk4tZ8IAfz2XPzzqblLCZ8ppqbBd3J2PW61KiPwxGFRP8B7f54knjuxU5ibTbHCFhmYkpb1MMJWxVtHFkMNTfI8P0mJD3JgqeD8PPSziQ+Y87qHf0HXA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(33656002)(10290500003)(8990500004)(110136005)(9686003)(921005)(2906002)(966005)(38070700005)(478600001)(7696005)(83380400001)(30864003)(82960400001)(86362001)(122000001)(82950400001)(71200400001)(76116006)(52536014)(786003)(316002)(64756008)(66556008)(66946007)(66446008)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(55016003)(5660300002)(41300700001)(6506007)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ha5xrmES6W5CKSDAB7/LjxUC7qArzaHQ988wjtru4glGI9bPTrcsZG+CBnne?=
 =?us-ascii?Q?Qx4xBNjnngyTDhaZLVKFiqmfS0VeaYDOD9/mn3bc5W6w+wh5OrIsMGZhTArK?=
 =?us-ascii?Q?oqi26og5XCrOl4JXMli/oSsvpz8itM/TJmunzynGOixnMihpXmyOmmYpPYKy?=
 =?us-ascii?Q?e5a4lYprzc1PfOeOH4njPGp8w+OVipKHYjt09VQEaPZcgosdBWvsZmswcXGg?=
 =?us-ascii?Q?DmCh4AoVpd/7Y1hnQKxPOSlGhme2M7NYfGxm/llcFy9J7F41dJ/86KBvkxYh?=
 =?us-ascii?Q?b6m7j6iwNEIDWgr65CgyGtOr/v9P7tv9JNHoB6+f6m+N/YXJeaCcVMJ6gfFC?=
 =?us-ascii?Q?gTYiCc3hQbw7FG/iRJOQVPDUx80xYo0aEWqOKO89Zh/czkcNIlIx1UkpGxXB?=
 =?us-ascii?Q?ouVkWP/m6TACh2uV8k2iDWGXfMyUFYvk1BD00LYoN6kk23mzR6emEsn0YgkH?=
 =?us-ascii?Q?SR5YAekJBtxkv19WtX4TuTUIxTDvlmr1DG1nxSKCwf+njq6iuiXJ6vnac9RW?=
 =?us-ascii?Q?ryccOtMN1TcrGsYnNCXTnZmw+zCtkLQ47o9m9DRwlhkA/BmXu5eI9amiuuZY?=
 =?us-ascii?Q?S0za4ur7GMF25chp19cNvXPXBs1xAo87ZhLIznLq69eaTq4A8rAzr/j3U3ae?=
 =?us-ascii?Q?LrNyBtKYX6nE3xdV40kw6GkxBrKbCIeRYAGkWnnr2WF+gMGDzSNGP3IU0nFw?=
 =?us-ascii?Q?9iUDveQdMaVktzPl4ZmIjBBMEh8A0PI24QaoSRz4ZxzjbdPxwlCKg71vfYgh?=
 =?us-ascii?Q?4X2ZDL8SGe5tBb2Z+Q81X7xwwosHXU8ubpzROLv4VuIYld6h8QmV9/H9UvHR?=
 =?us-ascii?Q?wh8hCTNFYerHHInJSODfoZjQ5bvrfoVnoN05f6D3IIHU7RpyMzFajRF+jMvj?=
 =?us-ascii?Q?b/FAFuY+pzWCV3SMxpb+QODTNyTEno7rMqBVD4uh4O7D1rf2vz2TGYa/Cvil?=
 =?us-ascii?Q?iXM1Yus6g3TXoYiHYIH4ROwitKIYVqcLWd5wNI1eD8VeZMtdwzMZF30t4yRL?=
 =?us-ascii?Q?Bnc/G3sP3SWRgBPIVw8uP8gv9vsvgBUVjPClLVafuJayrfrYvm/FosUIf3T7?=
 =?us-ascii?Q?p30JfaSGYILyAXtjFBjLQN+E0rE6ZyU1D0DTVKTah2JTDpweRovPFOXpiFGS?=
 =?us-ascii?Q?2hCVEaduyFB4YPISaaef4QA4MkZaEBtNYnLjlXEqaxg1bVFJUPzx9yOCFTjv?=
 =?us-ascii?Q?6xU/N8/O0fKOg07zfgr6IFPy78Hbj4vouzsMLyrO9t+E/L2ugp9FhXNkHrB8?=
 =?us-ascii?Q?mTvrxLO0G6L1ms+dIW9ZH9u67Ey5paXtpLcDBMhS1Q0N1CBXYsMbo5pkMBL4?=
 =?us-ascii?Q?4htyGOC3UKEqfLtEJmdxJ3AZ0QsWif1e90dwdWiR0XEIRsYsch1RdTwz9Ubf?=
 =?us-ascii?Q?PM7do7JiMcmFSfaUY9QNT0utHHGr6pBkIuwChZu/grkK514+4n1zIJWld/k1?=
 =?us-ascii?Q?BbaW3fuEx7mowLTqjwxzWIcu7u3Np9BBf3eqbHzGKOrhiim073zQpqtyV/SP?=
 =?us-ascii?Q?4GkIHpRz0xvMRYpb1psDSkvsSLQU1wWnvCf32AjnJ0Ri/K69PByPokY2Ndjk?=
 =?us-ascii?Q?rL7+wTFomWqWYgYJzxzvDYT96ylhZOAgnxtqnEu8PZEqAmax9Xoa1jsbu1Fc?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16d1617-5533-4aab-f7b7-08db93a1918c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 21:43:54.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P92LIT4N4cIjth8FmHyadfr5JbkbUDarN5ocwk+hleFgOIV/Hz66RB8+j8J3GuqD98RicUptyNDjxwLQgKLO3wZupqrIFXjrcuynfGnf3pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, July 14, 2=
023 3:26 AM
>=20
> Provide a userspace interface for userspace drivers or applications to
> read/write a VMBus ringbuffer. A significant part of this code is
> borrowed from DPDK[1]. Current library is supported exclusively for
> the x86 architecture.
>=20
> To build this library:
> make -C tools/hv libvmbus_bufring.a
>=20
> Applications using this library can include the vmbus_bufring.h header
> file and libvmbus_bufring.a statically.
>=20
> [1] https://github.com/DPDK/dpdk/
>=20
> Signed-off-by: Mary Hardy <maryhardy@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V3]
> - Made ring buffer data offset depend on page size
> - remove rte_smp_rwmb macro and reused rte_compiler_barrier instead
> - Added legal counsel sign-off
> - Removed "Link:" tag
> - Improve commit messages
> - new library compilation dependent on x86
> - simplify mmap
>=20
> [V2]
> - simpler sysfs path, less parsing
>=20
>  tools/hv/Build           |   1 +
>  tools/hv/Makefile        |  13 +-
>  tools/hv/vmbus_bufring.c | 297 +++++++++++++++++++++++++++++++++++++++
>  tools/hv/vmbus_bufring.h | 154 ++++++++++++++++++++
>  4 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hv/vmbus_bufring.c
>  create mode 100644 tools/hv/vmbus_bufring.h
>=20
> diff --git a/tools/hv/Build b/tools/hv/Build
> index 6cf51fa4b306..2a667d3d94cb 100644
> --- a/tools/hv/Build
> +++ b/tools/hv/Build
> @@ -1,3 +1,4 @@
>  hv_kvp_daemon-y +=3D hv_kvp_daemon.o
>  hv_vss_daemon-y +=3D hv_vss_daemon.o
>  hv_fcopy_daemon-y +=3D hv_fcopy_daemon.o
> +vmbus_bufring-y +=3D vmbus_bufring.o
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index fe770e679ae8..33cf488fd20f 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -11,14 +11,19 @@ srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>=20
> +include $(srctree)/tools/scripts/Makefile.arch
> +
>  # Do not use make's built-in rules
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>=20
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>=20
> +ifeq ($(SRCARCH),x86)
> +ALL_LIBS :=3D libvmbus_bufring.a
> +endif
>  ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> -ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> +ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst
> %,$(OUTPUT)%,$(ALL_LIBS))
>=20
>  ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.=
sh
>=20
> @@ -27,6 +32,12 @@ all: $(ALL_PROGRAMS)
>  export srctree OUTPUT CC LD CFLAGS
>  include $(srctree)/tools/build/Makefile.include
>=20
> +HV_VMBUS_BUFRING_IN :=3D $(OUTPUT)vmbus_bufring.o
> +$(HV_VMBUS_BUFRING_IN): FORCE
> +	$(Q)$(MAKE) $(build)=3Dvmbus_bufring
> +$(OUTPUT)libvmbus_bufring.a : vmbus_bufring.o
> +	$(AR) rcs $@ $^
> +
>  HV_KVP_DAEMON_IN :=3D $(OUTPUT)hv_kvp_daemon-in.o
>  $(HV_KVP_DAEMON_IN): FORCE
>  	$(Q)$(MAKE) $(build)=3Dhv_kvp_daemon
> diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
> new file mode 100644
> index 000000000000..fb1f0489c625
> --- /dev/null
> +++ b/tools/hv/vmbus_bufring.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> + * Copyright (c) 2012 NetApp Inc.
> + * Copyright (c) 2012 Citrix Inc.
> + * All rights reserved.
> + */
> +
> +#include <errno.h>
> +#include <emmintrin.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/uio.h>
> +#include "vmbus_bufring.h"
> +
> +#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
> +#define RINGDATA_START_OFFSET	(getpagesize())
> +#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
> +#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((align=
) - 1)))))
> +
> +/* Increase bufring index by inc with wraparound */
> +static inline uint32_t vmbus_br_idxinc(uint32_t idx, uint32_t inc, uint3=
2_t sz)
> +{
> +	idx +=3D inc;
> +	if (idx >=3D sz)
> +		idx -=3D sz;
> +
> +	return idx;
> +}
> +
> +void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
> +{
> +	br->vbr =3D buf;
> +	br->windex =3D br->vbr->windex;
> +	br->dsize =3D blen - RINGDATA_START_OFFSET;
> +}
> +
> +static inline __always_inline void
> +rte_smp_mb(void)
> +{
> +	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> +}
> +
> +static inline int
> +rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
> +{
> +	uint8_t res;
> +
> +	asm volatile("lock ; "
> +		     "cmpxchgl %[src], %[dst];"
> +		     "sete %[res];"
> +		     : [res] "=3Da" (res),     /* output */
> +		     [dst] "=3Dm" (*dst)
> +		     : [src] "r" (src),      /* input */
> +		     "a" (exp),
> +		     "m" (*dst)
> +		     : "memory");            /* no-clobber list */
> +	return res;
> +}
> +
> +static inline uint32_t
> +vmbus_txbr_copyto(const struct vmbus_br *tbr, uint32_t windex,
> +		  const void *src0, uint32_t cplen)
> +{
> +	uint8_t *br_data =3D (uint8_t *)tbr->vbr + RINGDATA_START_OFFSET;
> +	uint32_t br_dsize =3D tbr->dsize;
> +	const uint8_t *src =3D src0;
> +
> +	if (cplen > br_dsize - windex) {
> +		uint32_t fraglen =3D br_dsize - windex;
> +
> +		/* Wrap-around detected */
> +		memcpy(br_data + windex, src, fraglen);
> +		memcpy(br_data, src + fraglen, cplen - fraglen);
> +	} else {
> +		memcpy(br_data + windex, src, cplen);
> +	}
> +
> +	return vmbus_br_idxinc(windex, cplen, br_dsize);
> +}
> +
> +/*
> + * Write scattered channel packet to TX bufring.
> + *
> + * The offset of this channel packet is written as a 64bits value
> + * immediately after this channel packet.
> + *
> + * The write goes through three stages:
> + *  1. Reserve space in ring buffer for the new data.
> + *     Writer atomically moves priv_write_index.
> + *  2. Copy the new data into the ring.
> + *  3. Update the tail of the ring (visible to host) that indicates
> + *     next read location. Writer updates write_index
> + */
> +static int
> +vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iov=
len,
> +		 bool *need_sig)
> +{
> +	struct vmbus_bufring *vbr =3D tbr->vbr;
> +	uint32_t ring_size =3D tbr->dsize;
> +	uint32_t old_windex, next_windex, windex, total;
> +	uint64_t save_windex;
> +	int i;
> +
> +	total =3D 0;
> +	for (i =3D 0; i < iovlen; i++)
> +		total +=3D iov[i].iov_len;
> +	total +=3D sizeof(save_windex);
> +
> +	/* Reserve space in ring */
> +	do {
> +		uint32_t avail;
> +
> +		/* Get current free location */
> +		old_windex =3D tbr->windex;
> +
> +		/* Prevent compiler reordering this with calculation */
> +		rte_compiler_barrier();
> +
> +		avail =3D vmbus_br_availwrite(tbr, old_windex);
> +
> +		/* If not enough space in ring, then tell caller. */
> +		if (avail <=3D total)
> +			return -EAGAIN;
> +
> +		next_windex =3D vmbus_br_idxinc(old_windex, total, ring_size);
> +
> +		/* Atomic update of next write_index for other threads */
> +	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex, next_windex));
> +
> +	/* Space from old..new is now reserved */
> +	windex =3D old_windex;
> +	for (i =3D 0; i < iovlen; i++)
> +		windex =3D vmbus_txbr_copyto(tbr, windex, iov[i].iov_base, iov[i].iov_=
len);
> +
> +	/* Set the offset of the current channel packet. */
> +	save_windex =3D ((uint64_t)old_windex) << 32;
> +	windex =3D vmbus_txbr_copyto(tbr, windex, &save_windex,
> +				   sizeof(save_windex));
> +
> +	/* The region reserved should match region used */
> +	if (windex !=3D next_windex)
> +		return -EINVAL;
> +
> +	/* Ensure that data is available before updating host index */
> +	rte_compiler_barrier();
> +
> +	/* Checkin for our reservation. wait for our turn to update host */
> +	while (!rte_atomic32_cmpset(&vbr->windex, old_windex, next_windex))
> +		_mm_pause();
> +
> +	return 0;
> +}
> +
> +int rte_vmbus_chan_send(struct vmbus_br *txbr, uint16_t type, void *data=
,
> +			uint32_t dlen, uint32_t flags)
> +{
> +	struct vmbus_chanpkt pkt;
> +	unsigned int pktlen, pad_pktlen;
> +	const uint32_t hlen =3D sizeof(pkt);
> +	bool send_evt =3D false;
> +	uint64_t pad =3D 0;
> +	struct iovec iov[3];
> +	int error;
> +
> +	pktlen =3D hlen + dlen;
> +	pad_pktlen =3D ALIGN(pktlen, sizeof(uint64_t));

This ALIGN function rounds down.  So pad_pktlen could be
less than pktlen.

> +
> +	pkt.hdr.type =3D type;
> +	pkt.hdr.flags =3D flags;
> +	pkt.hdr.hlen =3D hlen >> VMBUS_CHANPKT_SIZE_SHIFT;
> +	pkt.hdr.tlen =3D pad_pktlen >> VMBUS_CHANPKT_SIZE_SHIFT;
> +	pkt.hdr.xactid =3D VMBUS_RQST_ERROR; /* doesn't support multiple reques=
ts at same time */
> +
> +	iov[0].iov_base =3D &pkt;
> +	iov[0].iov_len =3D hlen;
> +	iov[1].iov_base =3D data;
> +	iov[1].iov_len =3D dlen;
> +	iov[2].iov_base =3D &pad;
> +	iov[2].iov_len =3D pad_pktlen - pktlen;

Given the way your ALIGN function works, the above could
produce a negative value for iov[2].iov_len.  Then bad things
will happen. :-(

> +
> +	error =3D vmbus_txbr_write(txbr, iov, 3, &send_evt);
> +
> +	return error;
> +}
> +
> +static inline uint32_t
> +vmbus_rxbr_copyfrom(const struct vmbus_br *rbr, uint32_t rindex,
> +		    void *dst0, size_t cplen)
> +{
> +	const uint8_t *br_data =3D (uint8_t *)rbr->vbr + RINGDATA_START_OFFSET;
> +	uint32_t br_dsize =3D rbr->dsize;
> +	uint8_t *dst =3D dst0;
> +
> +	if (cplen > br_dsize - rindex) {
> +		uint32_t fraglen =3D br_dsize - rindex;
> +
> +		/* Wrap-around detected. */
> +		memcpy(dst, br_data + rindex, fraglen);
> +		memcpy(dst + fraglen, br_data, cplen - fraglen);
> +	} else {
> +		memcpy(dst, br_data + rindex, cplen);
> +	}
> +
> +	return vmbus_br_idxinc(rindex, cplen, br_dsize);
> +}
> +
> +/* Copy data from receive ring but don't change index */
> +static int
> +vmbus_rxbr_peek(const struct vmbus_br *rbr, void *data, size_t dlen)
> +{
> +	uint32_t avail;
> +
> +	/*
> +	 * The requested data and the 64bits channel packet
> +	 * offset should be there at least.
> +	 */
> +	avail =3D vmbus_br_availread(rbr);
> +	if (avail < dlen + sizeof(uint64_t))
> +		return -EAGAIN;
> +
> +	vmbus_rxbr_copyfrom(rbr, rbr->vbr->rindex, data, dlen);
> +	return 0;
> +}
> +
> +/*
> + * Copy data from receive ring and change index
> + * NOTE:
> + * We assume (dlen + skip) =3D=3D sizeof(channel packet).
> + */
> +static int
> +vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t sk=
ip)
> +{
> +	struct vmbus_bufring *vbr =3D rbr->vbr;
> +	uint32_t br_dsize =3D rbr->dsize;
> +	uint32_t rindex;
> +
> +	if (vmbus_br_availread(rbr) < dlen + skip + sizeof(uint64_t))
> +		return -EAGAIN;
> +
> +	/* Record where host was when we started read (for debug) */
> +	rbr->windex =3D rbr->vbr->windex;
> +
> +	/*
> +	 * Copy channel packet from RX bufring.
> +	 */
> +	rindex =3D vmbus_br_idxinc(rbr->vbr->rindex, skip, br_dsize);
> +	rindex =3D vmbus_rxbr_copyfrom(rbr, rindex, data, dlen);
> +
> +	/*
> +	 * Discard this channel packet's 64bits offset, which is useless to us.
> +	 */
> +	rindex =3D vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
> +
> +	/* Update the read index _after_ the channel packet is fetched.	 */
> +	rte_compiler_barrier();
> +
> +	vbr->rindex =3D rindex;
> +
> +	return 0;
> +}
> +
> +int rte_vmbus_chan_recv_raw(struct vmbus_br *rxbr,
> +			    void *data, uint32_t *len)
> +{
> +	struct vmbus_chanpkt_hdr pkt;
> +	uint32_t dlen, bufferlen =3D *len;
> +	int error;
> +
> +	error =3D vmbus_rxbr_peek(rxbr, &pkt, sizeof(pkt));
> +	if (error)
> +		return error;
> +
> +	if (unlikely(pkt.hlen < VMBUS_CHANPKT_HLEN_MIN))
> +		/* XXX this channel is dead actually. */
> +		return -EIO;
> +
> +	if (unlikely(pkt.hlen > pkt.tlen))
> +		return -EIO;
> +
> +	/* Length are in quad words */
> +	dlen =3D pkt.tlen << VMBUS_CHANPKT_SIZE_SHIFT;
> +	*len =3D dlen;
> +
> +	/* If caller buffer is not large enough */
> +	if (unlikely(dlen > bufferlen))
> +		return -ENOBUFS;
> +
> +	/* Read data and skip packet header */
> +	error =3D vmbus_rxbr_read(rxbr, data, dlen, 0);
> +	if (error)
> +		return error;
> +
> +	/* Return the number of bytes read */
> +	return dlen + sizeof(uint64_t);
> +}
> diff --git a/tools/hv/vmbus_bufring.h b/tools/hv/vmbus_bufring.h
> new file mode 100644
> index 000000000000..45ecc48e517f
> --- /dev/null
> +++ b/tools/hv/vmbus_bufring.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +
> +#ifndef _VMBUS_BUF_H_
> +#define _VMBUS_BUF_H_
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#define __packed   __attribute__((__packed__))
> +#define unlikely(x)	__builtin_expect(!!(x), 0)
> +
> +#define ICMSGHDRFLAG_TRANSACTION	1
> +#define ICMSGHDRFLAG_REQUEST		2
> +#define ICMSGHDRFLAG_RESPONSE		4
> +
> +#define IC_VERSION_NEGOTIATION_MAX_VER_COUNT 100
> +#define ICMSG_HDR (sizeof(struct vmbuspipe_hdr) + sizeof(struct icmsg_hd=
r))
> +#define ICMSG_NEGOTIATE_PKT_SIZE(icframe_vercnt, icmsg_vercnt) \
> +	(ICMSG_HDR + sizeof(struct icmsg_negotiate) + \
> +	 (((icframe_vercnt) + (icmsg_vercnt)) * sizeof(struct ic_version)))
> +
> +/*
> + * Channel packets
> + */
> +
> +/* Channel packet flags */
> +#define VMBUS_CHANPKT_TYPE_INBAND	0x0006
> +#define VMBUS_CHANPKT_TYPE_RXBUF	0x0007
> +#define VMBUS_CHANPKT_TYPE_GPA		0x0009
> +#define VMBUS_CHANPKT_TYPE_COMP		0x000b
> +
> +#define VMBUS_CHANPKT_FLAG_NONE		0
> +#define VMBUS_CHANPKT_FLAG_RC		0x0001  /* report completion */
> +
> +#define VMBUS_CHANPKT_SIZE_SHIFT	3
> +#define VMBUS_CHANPKT_SIZE_ALIGN	BIT(VMBUS_CHANPKT_SIZE_SHIFT)
> +#define VMBUS_CHANPKT_HLEN_MIN		\
> +	(sizeof(struct vmbus_chanpkt_hdr) >> VMBUS_CHANPKT_SIZE_SHIFT)
> +
> +/*
> + * Buffer ring
> + */
> +struct vmbus_bufring {
> +	volatile uint32_t windex;
> +	volatile uint32_t rindex;
> +
> +	/*
> +	 * Interrupt mask {0,1}
> +	 *
> +	 * For TX bufring, host set this to 1, when it is processing
> +	 * the TX bufring, so that we can safely skip the TX event
> +	 * notification to host.
> +	 *
> +	 * For RX bufring, once this is set to 1 by us, host will not
> +	 * further dispatch interrupts to us, even if there are data
> +	 * pending on the RX bufring.  This effectively disables the
> +	 * interrupt of the channel to which this RX bufring is attached.
> +	 */
> +	volatile uint32_t imask;
> +
> +	/*
> +	 * Win8 uses some of the reserved bits to implement
> +	 * interrupt driven flow management. On the send side
> +	 * we can request that the receiver interrupt the sender
> +	 * when the ring transitions from being full to being able
> +	 * to handle a message of size "pending_send_sz".
> +	 *
> +	 * Add necessary state for this enhancement.
> +	 */
> +	volatile uint32_t pending_send;
> +	uint32_t reserved1[12];
> +
> +	union {
> +		struct {
> +			uint32_t feat_pending_send_sz:1;
> +		};
> +		uint32_t value;
> +	} feature_bits;
> +
> +	/*
> +	 * Ring data starts here + RingDataStartOffset

This mention of RingDataStartOffset looks stale.  I could
not find it defined anywhere.

> +	 * !!! DO NOT place any fields below this !!!
> +	 */
> +	uint8_t data[];
> +} __packed;
> +
> +struct vmbus_br {
> +	struct vmbus_bufring *vbr;
> +	uint32_t	dsize;
> +	uint32_t	windex; /* next available location */
> +};
> +
> +struct vmbus_chanpkt_hdr {
> +	uint16_t	type;	/* VMBUS_CHANPKT_TYPE_ */
> +	uint16_t	hlen;	/* header len, in 8 bytes */
> +	uint16_t	tlen;	/* total len, in 8 bytes */
> +	uint16_t	flags;	/* VMBUS_CHANPKT_FLAG_ */
> +	uint64_t	xactid;
> +} __packed;
> +
> +struct vmbus_chanpkt {
> +	struct vmbus_chanpkt_hdr hdr;
> +} __packed;
> +
> +struct vmbuspipe_hdr {
> +	unsigned int flags;
> +	unsigned int msgsize;
> +} __packed;
> +
> +struct ic_version {
> +	unsigned short major;
> +	unsigned short minor;
> +} __packed;
> +
> +struct icmsg_negotiate {
> +	unsigned short icframe_vercnt;
> +	unsigned short icmsg_vercnt;
> +	unsigned int reserved;
> +	struct ic_version icversion_data[]; /* any size array */
> +} __packed;
> +
> +struct icmsg_hdr {
> +	struct ic_version icverframe;
> +	unsigned short icmsgtype;
> +	struct ic_version icvermsg;
> +	unsigned short icmsgsize;
> +	unsigned int status;
> +	unsigned char ictransaction_id;
> +	unsigned char icflags;
> +	unsigned char reserved[2];
> +} __packed;
> +
> +int rte_vmbus_chan_recv_raw(struct vmbus_br *rxbr, void *data, uint32_t =
*len);
> +int rte_vmbus_chan_send(struct vmbus_br *txbr, uint16_t type, void *data=
,
> +			uint32_t dlen, uint32_t flags);
> +void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen);
> +
> +/* Amount of space available for write */
> +static inline uint32_t vmbus_br_availwrite(const struct vmbus_br *br, ui=
nt32_t
> windex)
> +{
> +	uint32_t rindex =3D br->vbr->rindex;
> +
> +	if (windex >=3D rindex)
> +		return br->dsize - (windex - rindex);
> +	else
> +		return rindex - windex;
> +}
> +
> +static inline uint32_t vmbus_br_availread(const struct vmbus_br *br)
> +{
> +	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
> +}
> +
> +#endif	/* !_VMBUS_BUF_H_ */
> --
> 2.34.1

