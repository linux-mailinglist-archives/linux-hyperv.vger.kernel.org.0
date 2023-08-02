Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F276D9E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 23:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHBVqh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjHBVqR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 17:46:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A194268F;
        Wed,  2 Aug 2023 14:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8ejla2c3rkrWzXwgxxBXyBJ13lMF9+vaGPtzYIScv32NoQBMetnKSPzYdqatAbhHJYEoIWnBxo7Gxi69tpq2JLu7kdo9mtmklhNBLwYC6U3hmAHLzLt612bnLeGX9XopDtDDa4lZXcoetYwZswKclN+KVGSDN/FOqIVvSYalRaVAMyjVFtG4hjTy968GL9PNoY0zW9Le83rS9kqWhpzIyyApcKUEtQM3LiwmCHzQrlGWF7KJu1SnSngRQwIN0H3AChGTUCxI/yidBsdo91CxD9xtcFktwZXahLRMq6Z3XsAGamY77FHXZqRNLZYZIwCOuo+geZ8yHcMuOdAMqcRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3rbyQYVHXjMPGd2tE1ngXRqeB0W85HoMEX+yF21Y/E=;
 b=Q8pwdqZ1kUvrPm5X1u3cdkVaxNWn1BnZxoBoTEREfZLmkbb6464EQp7DYt28GpB+Pz4hLg/fP4tK+D9veBGYHAKXtft//3BSDvP5DksQo+HxivJcrv2ikcpgPzX1Ael7iSQEZXxKZ97pP5/XsvXlSO/DI6i11ozhfxI1NfBX//rluGD2SYVk6W+G/WhzEa74Xn3rf2cM+J0i+B9wxCpmrAndw3oVAGFc4wo6q5wvSkIYvWxFqzYZHMJknISmQnhpaa0IVy+aNehrgL1qWg7axa30U8tPcYNxR6fHuf+VQWS/8gf9/EV2jkRYW/POoKDwdpsL6QQGDZOlPYpMuXDCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3rbyQYVHXjMPGd2tE1ngXRqeB0W85HoMEX+yF21Y/E=;
 b=PaXYEuAPXL4wVEDWc0loJmiVekseGfnGYCdn3mcnekR+IZOmRu5zmW4VO08cWTp1GBZcV2En2iSLSC3jL4DoEaPiq8nlzpFNTc2AYCTsv4Z5ZWz7NCIVCp9CuKtQpiBZCZEafL69QooILxFy0E5riBpBL2Y30wz6bHCE+pqdDEE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA3PR21MB3866.namprd21.prod.outlook.com (2603:10b6:806:2fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 21:45:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 21:45:16 +0000
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
Subject: RE: [PATCH v3 3/3] tools: hv: Add new fcopy application based on uio
 driver
Thread-Topic: [PATCH v3 3/3] tools: hv: Add new fcopy application based on uio
 driver
Thread-Index: AQHZtj2UkBd0/zRLlEWpc4uymEEQD6/XpHpg
Date:   Wed, 2 Aug 2023 21:45:16 +0000
Message-ID: <BYAPR21MB16884ABB3DAD7B8213EF5D6DD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
 <1689330346-5374-4-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1689330346-5374-4-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a2f2bef-00c7-44e0-9159-1e8fedfdb809;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T21:29:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA3PR21MB3866:EE_
x-ms-office365-filtering-correlation-id: c91d1455-6f0c-46cc-121a-08db93a1c284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlEoBHGAl5P6/nKZSZbLYB7NhZzrC5KEX2ohIjb9StObOtG0YzsJp8uDew3k4JjehnGYFO+2e7/0GSFlsHmKGtyTmzkNMpA+6v1Bt4rQbpchov3nSVffQO36Efv7vEkVsyxZaHWIMHairwwCHk80rKSiXxwuqtYqBs21xW0zuDezqmFHfPKC0cJj2dNdA5puwZlzYoj7kCEPhwkxom06ZWZs1pqWUIKvCt+w5LwXXPb7olYKhxWfwLzEHZPXzbPVqhBIZEk/Mgu93P7zUPBvZwkHbhMU7jYEA4brQiYgvT6J5zEza6Qqi61JnQMGhqnScC/pQ6i5j3oOSFErOfdhwAp6AuuxSlbxUhxpyo17UwPexsn5oz3dx0FTQXLr3JVP/PL21S5mZVSth1Z2Tg3w4k4k8eUKM+YkvoIlUszoRZfJjgI63dTTgwv/pXHPwzyQQBC+byNr0H4BmCVt/0VWkZkqB+Szz5CtQfMGt+VS+PyPXiUWYTfRWRKN0q84BcA3aeUJn6UB7UJiHs/k4l56fN5IqaZvW2xmFfRyy9WX6xy3GggJOXQay/jNHycXIo93KPnVLlTAjfBQRN6kcEsc6WVwGTQSj0jhfQMXdkmw/6HQbEa/bspNxPZBdhsTmWqNiWqhlQK2UvpxUhELfCxy4Yu9OtF2JCKuABn9sHi9UqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(8936002)(6506007)(10290500003)(82950400001)(82960400001)(186003)(9686003)(110136005)(966005)(7696005)(26005)(122000001)(71200400001)(921005)(478600001)(66556008)(64756008)(66476007)(83380400001)(76116006)(66446008)(38100700002)(66946007)(52536014)(30864003)(8676002)(2906002)(38070700005)(41300700001)(786003)(316002)(55016003)(8990500004)(86362001)(5660300002)(33656002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OZSHDuxn/jsfYDzmbz56g6G0gAbHRYBM16M6W7KQlz9ZJ2H63sA71TW39aKb?=
 =?us-ascii?Q?M1AmjDkeO0fslWtOKgWRL40tjPf3yVhuv1J3xbnYLaOT5NyyfzdwWvtDDr2x?=
 =?us-ascii?Q?EneOo+jPtX7b3n68El22ijQ/Wg629Sc+3gI38FhZcJHmFKCHZ6COIJ01Yqzm?=
 =?us-ascii?Q?AVt4CnnnavAESDkrZqWPR6qk1zFthixpal0ejaNsjnwU3u34B4bm0CQAtr28?=
 =?us-ascii?Q?cOW45DLkNRJ5ah336Y8NHYiRocRPzuiyR1BDZADKegufOWjcRtUQnN1/8tGp?=
 =?us-ascii?Q?EJNaAwtEcF8JZv5vR81oWTOAXF2odNPpiMmKarZ25CzVfGWx+ZPeF4gHvNNb?=
 =?us-ascii?Q?tJbqRQgR7cLBUJJKsreH3pzIkDOGfElsDf7E5E5OQsTHQuG+9GE8y6sWNOPe?=
 =?us-ascii?Q?Uxpc/zEPpFassPWOHVZKlI0BXEd5ltRJvijZkF18A6zaxOHaxwLRW2t/7dWs?=
 =?us-ascii?Q?OsnJgp9/AY7FloCqlmL7roq4zEZXDYdIV4bWN2KsShqY4AovSvDfMDK/iOqI?=
 =?us-ascii?Q?rZWzbTmTx5DKUDjWyc/enTg+jrnvzVMU8ZBV7vtzyfkRwm4cGX377OZjVt57?=
 =?us-ascii?Q?+kplvbIARa2Mt7tLK3VwDH7IUJFqLAcvVbS7kHUBXFqElxZrKj4WKElSQeZ1?=
 =?us-ascii?Q?EcpQOjqufp6dGgUKJyBHdeb3zVfXJLykKDBtC7ZuZcSvTcKrTzw/4psqH4QX?=
 =?us-ascii?Q?ibV/KN0JXQCYQeWaaA4J6TYHdljAT4ywqGgp8YZN+1/lAhziC7eBj+DJUu/N?=
 =?us-ascii?Q?OtbJ5JrtSrV1sRdIyZPKk7CRjjTY5iPcJvLCP+VAE1FNibkP9IDIlIaVQ0An?=
 =?us-ascii?Q?RAMizMxQTyelbZpHa7Ek7u1IWF0QdF4WICuVctV5xkcwZn7vdCSFLt16tVsp?=
 =?us-ascii?Q?DqEVIk+zLxwN/WhY6NxMF6XKKmE+Wlczw+OM/0nsMnKfhIgsTHseANqIG4uD?=
 =?us-ascii?Q?Rvg6SnXbz8LpY6aVTUear9tVtXQLE4z3RTYHs3TQJLXe0U1nsXTMG+JJHJxD?=
 =?us-ascii?Q?9ADTZxc+MnNdQmxhKur7YaAFx/WpUnUVr4u6tl/a2UZPV5hkTF5c5hSJTy71?=
 =?us-ascii?Q?9DO9n1waPJbV3nT0B0LIF52p/hpGWSuMLjieTN97ORBd8Hc9JT/0SaeGdJJJ?=
 =?us-ascii?Q?piPS0MCKAHso6WLpwleXXfXaUS7QjjN31NvxWKPy1kGkjgQa057KnCfTRB9z?=
 =?us-ascii?Q?ot4aa62pUcfWFiR80xyyYsA4zu0Zp5l5Xpxy6N1A4s5fh+dO2BFq8qqBhXum?=
 =?us-ascii?Q?3dx+/1Q9YpB484Iwncaargt23KzwmCRxktz5uEaEwcRteHF1F0d2wHvGAA2T?=
 =?us-ascii?Q?wqgXc7O6i/CKLAx4dZkufNYDaRMk0p4ECa8vfPj1NnbiXqwZ/u8BKCSCjNaP?=
 =?us-ascii?Q?AR/STMg72rojJbfsSMdWiSjQM+J4MZ63Cw8rLcvXn2WcreEeUajnLTe1no+b?=
 =?us-ascii?Q?zxZn/X0NgFpN43/au8AvhLKKgPrA2kV880wAkWLVnATd/WXBD5DjAvuLJvb6?=
 =?us-ascii?Q?ysnaxqNog6CVNxdn3JfIifxN8MPWoCaXVt/ntjWBx8tY/sCtQdx3WVd6R4J0?=
 =?us-ascii?Q?85ufPpugue9/EyvTeA90Upd0XlGm19kUewBgbkL3cJaBD3JwQbv4/qek1ffu?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91d1455-6f0c-46cc-121a-08db93a1c284
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 21:45:16.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqH6enVJbKWHi+cqihjt6OFgLiUMpgE7vY7V3ar39Q0fwvSWsDjC5X3uT7dPcbKPW++rxQDBxdZajFvgVyU84zgS8gVJYWvEtcqnDuBJgMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, July 14, 2=
023 3:26 AM
>=20
> Implement the file copy service for Linux guests on Hyper-V. This
> permits the host to copy a file (over VMBus) into the guest. This
> facility is part of "guest integration services" supported on the
> Hyper-V platform.
>=20
> Here is a link that provides additional details on this functionality:
>=20
> https://learn.microsoft.com/en-us/powershell/module/hyper-v/copy-vmfile?v=
iew=3Dwindowsserver2022-ps
>=20
> This new fcopy application uses uio_hv_vmbus_client driver which
> makes the earlier hv_util based driver and application obsolete.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V3]
> - Improve cover letter and commit messages
> - Improve debug prints
> - Instead of hardcoded instance id, query from class id sysfs
> - Set the ring_size value from application
> - Update the application to mmap /dev/uio instead of sysfs
> - new application compilation dependent on x86
>=20
> [V2]
> - simpler sysfs path
>=20
>  tools/hv/Build                 |   1 +
>  tools/hv/Makefile              |  10 +-
>  tools/hv/hv_fcopy_uio_daemon.c | 578 +++++++++++++++++++++++++++++++++
>  3 files changed, 588 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
>=20
> diff --git a/tools/hv/Build b/tools/hv/Build
> index 2a667d3d94cb..efcbb74a0d23 100644
> --- a/tools/hv/Build
> +++ b/tools/hv/Build
> @@ -2,3 +2,4 @@ hv_kvp_daemon-y +=3D hv_kvp_daemon.o
>  hv_vss_daemon-y +=3D hv_vss_daemon.o
>  hv_fcopy_daemon-y +=3D hv_fcopy_daemon.o
>  vmbus_bufring-y +=3D vmbus_bufring.o
> +hv_fcopy_uio_daemon-y +=3D hv_fcopy_uio_daemon.o
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 33cf488fd20f..678c6c450a53 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -21,8 +21,10 @@ override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -
> I$(OUTPUT)include
>=20
>  ifeq ($(SRCARCH),x86)
>  ALL_LIBS :=3D libvmbus_bufring.a
> -endif
> +ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> hv_fcopy_uio_daemon
> +else
>  ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> +endif
>  ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst
> %,$(OUTPUT)%,$(ALL_LIBS))
>=20
>  ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.=
sh
> @@ -56,6 +58,12 @@ $(HV_FCOPY_DAEMON_IN): FORCE
>  $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
>=20
> +HV_FCOPY_UIO_DAEMON_IN :=3D $(OUTPUT)hv_fcopy_uio_daemon-in.o
> +$(HV_FCOPY_UIO_DAEMON_IN): FORCE
> +	$(Q)$(MAKE) $(build)=3Dhv_fcopy_uio_daemon
> +$(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
> libvmbus_bufring.a
> +	$(QUIET_LINK)$(CC) -lm $< -L. -lvmbus_bufring -o $@
> +
>  clean:
>  	rm -f $(ALL_PROGRAMS)
>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemo=
n.c
> new file mode 100644
> index 000000000000..e8618a30dc7e
> --- /dev/null
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * An implementation of host to guest copy functionality for Linux.
> + *
> + * Copyright (C) 2023, Microsoft, Inc.
> + *
> + * Author : K. Y. Srinivasan <kys@microsoft.com>
> + * Author : Saurabh Sengar <ssengar@microsoft.com>
> + *
> + */
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <locale.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syslog.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <linux/hyperv.h>
> +#include "vmbus_bufring.h"
> +
> +#define ICMSGTYPE_NEGOTIATE	0
> +#define ICMSGTYPE_FCOPY		7
> +
> +#define WIN8_SRV_MAJOR		1
> +#define WIN8_SRV_MINOR		1
> +#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
> +
> +#define MAX_PATH_LEN		300
> +#define MAX_LINE_LEN		40
> +#define DEVICES_SYSFS		"/sys/bus/vmbus/devices"
> +#define FCOPY_CLASS_ID		"34d14be3-dee4-41c8-9ae7-6b174977c192"
> +
> +#define FCOPY_VER_COUNT		1
> +static const int fcopy_versions[] =3D {
> +	WIN8_SRV_VERSION
> +};
> +
> +#define FW_VER_COUNT		1
> +static const int fw_versions[] =3D {
> +	UTIL_FW_VERSION
> +};
> +
> +#define HV_RING_SIZE		(4 * 4096)
> +
> +unsigned char desc[HV_RING_SIZE];
> +
> +static int target_fd;
> +static char target_fname[PATH_MAX];
> +static unsigned long long filesize;
> +
> +static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 =
flags)
> +{
> +	int error =3D HV_E_FAIL;
> +	char *q, *p;
> +
> +	filesize =3D 0;
> +	p =3D (char *)path_name;
> +	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> +		 (char *)path_name, (char *)file_name);
> +
> +	/*
> +	 * Check to see if the path is already in place; if not,
> +	 * create if required.
> +	 */
> +	while ((q =3D strchr(p, '/')) !=3D NULL) {
> +		if (q =3D=3D p) {
> +			p++;
> +			continue;
> +		}
> +		*q =3D '\0';
> +		if (access(path_name, F_OK)) {
> +			if (flags & CREATE_PATH) {
> +				if (mkdir(path_name, 0755)) {
> +					syslog(LOG_ERR, "Failed to create %s",
> +					       path_name);
> +					goto done;
> +				}
> +			} else {
> +				syslog(LOG_ERR, "Invalid path: %s", path_name);
> +				goto done;
> +			}
> +		}
> +		p =3D q + 1;
> +		*q =3D '/';
> +	}
> +
> +	if (!access(target_fname, F_OK)) {
> +		syslog(LOG_INFO, "File: %s exists", target_fname);
> +		if (!(flags & OVER_WRITE)) {
> +			error =3D HV_ERROR_ALREADY_EXISTS;
> +			goto done;
> +		}
> +	}
> +
> +	target_fd =3D open(target_fname,
> +			 O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0744);
> +	if (target_fd =3D=3D -1) {
> +		syslog(LOG_INFO, "Open Failed: %s", strerror(errno));
> +		goto done;
> +	}
> +
> +	error =3D 0;
> +done:
> +	if (error)
> +		target_fname[0] =3D '\0';
> +	return error;
> +}
> +
> +static int hv_copy_data(struct hv_do_fcopy *cpmsg)
> +{
> +	ssize_t bytes_written;
> +	int ret =3D 0;
> +
> +	bytes_written =3D pwrite(target_fd, cpmsg->data, cpmsg->size,
> +			       cpmsg->offset);
> +
> +	filesize +=3D cpmsg->size;
> +	if (bytes_written !=3D cpmsg->size) {
> +		switch (errno) {
> +		case ENOSPC:
> +			ret =3D HV_ERROR_DISK_FULL;
> +			break;
> +		default:
> +			ret =3D HV_E_FAIL;
> +			break;
> +		}
> +		syslog(LOG_ERR, "pwrite failed to write %llu bytes: %ld (%s)",
> +		       filesize, (long)bytes_written, strerror(errno));
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Reset target_fname to "" in the two below functions for hibernation: =
if
> + * the fcopy operation is aborted by hibernation, the daemon should remo=
ve the
> + * partially-copied file; to achieve this, the hv_utils driver always fa=
kes a
> + * CANCEL_FCOPY message upon suspend, and later when the VM resumes back=
,
> + * the daemon calls hv_copy_cancel() to remove the file; if a file is co=
pied
> + * successfully before suspend, hv_copy_finished() must reset target_fna=
me to
> + * avoid that the file can be incorrectly removed upon resume, since the=
 faked
> + * CANCEL_FCOPY message is spurious in this case.
> + */
> +static int hv_copy_finished(void)
> +{
> +	close(target_fd);
> +	target_fname[0] =3D '\0';
> +	return 0;
> +}
> +
> +static void print_usage(char *argv[])
> +{
> +	fprintf(stderr, "Usage: %s [options]\n"
> +		"Options are:\n"
> +		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
> +		"  -h, --help             print this help\n", argv[0]);
> +}
> +
> +static bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, unsig=
ned char *buf,
> +				      unsigned int buflen, const int *fw_version, int fw_vercnt,
> +				const int *srv_version, int srv_vercnt,
> +				int *nego_fw_version, int *nego_srv_version)
> +{
> +	int icframe_major, icframe_minor;
> +	int icmsg_major, icmsg_minor;
> +	int fw_major, fw_minor;
> +	int srv_major, srv_minor;
> +	int i, j;
> +	bool found_match =3D false;
> +	struct icmsg_negotiate *negop;
> +
> +	/* Check that there's enough space for icframe_vercnt, icmsg_vercnt */
> +	if (buflen < ICMSG_HDR + offsetof(struct icmsg_negotiate, reserved)) {
> +		syslog(LOG_ERR, "Invalid icmsg negotiate");
> +		return false;
> +	}
> +
> +	icmsghdrp->icmsgsize =3D 0x10;
> +	negop =3D (struct icmsg_negotiate *)&buf[ICMSG_HDR];
> +
> +	icframe_major =3D negop->icframe_vercnt;
> +	icframe_minor =3D 0;
> +
> +	icmsg_major =3D negop->icmsg_vercnt;
> +	icmsg_minor =3D 0;
> +
> +	/* Validate negop packet */
> +	if (icframe_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
> +	    icmsg_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
> +	    ICMSG_NEGOTIATE_PKT_SIZE(icframe_major, icmsg_major) > buflen) {
> +		syslog(LOG_ERR, "Invalid icmsg negotiate - icframe_major: %u, icmsg_ma=
jor: %u\n",
> +		       icframe_major, icmsg_major);
> +		goto fw_error;
> +	}
> +
> +	/*
> +	 * Select the framework version number we will
> +	 * support.
> +	 */
> +
> +	for (i =3D 0; i < fw_vercnt; i++) {
> +		fw_major =3D (fw_version[i] >> 16);
> +		fw_minor =3D (fw_version[i] & 0xFFFF);
> +
> +		for (j =3D 0; j < negop->icframe_vercnt; j++) {
> +			if (negop->icversion_data[j].major =3D=3D fw_major &&
> +			    negop->icversion_data[j].minor =3D=3D fw_minor) {
> +				icframe_major =3D negop->icversion_data[j].major;
> +				icframe_minor =3D negop->icversion_data[j].minor;
> +				found_match =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (found_match)
> +			break;
> +	}
> +
> +	if (!found_match)
> +		goto fw_error;
> +
> +	found_match =3D false;
> +
> +	for (i =3D 0; i < srv_vercnt; i++) {
> +		srv_major =3D (srv_version[i] >> 16);
> +		srv_minor =3D (srv_version[i] & 0xFFFF);
> +
> +		for (j =3D negop->icframe_vercnt;
> +			(j < negop->icframe_vercnt + negop->icmsg_vercnt);
> +			j++) {
> +			if (negop->icversion_data[j].major =3D=3D srv_major &&
> +			    negop->icversion_data[j].minor =3D=3D srv_minor) {
> +				icmsg_major =3D negop->icversion_data[j].major;
> +				icmsg_minor =3D negop->icversion_data[j].minor;
> +				found_match =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (found_match)
> +			break;
> +	}
> +
> +	/*
> +	 * Respond with the framework and service
> +	 * version numbers we can support.
> +	 */
> +fw_error:
> +	if (!found_match) {
> +		negop->icframe_vercnt =3D 0;
> +		negop->icmsg_vercnt =3D 0;
> +	} else {
> +		negop->icframe_vercnt =3D 1;
> +		negop->icmsg_vercnt =3D 1;
> +	}
> +
> +	if (nego_fw_version)
> +		*nego_fw_version =3D (icframe_major << 16) | icframe_minor;
> +
> +	if (nego_srv_version)
> +		*nego_srv_version =3D (icmsg_major << 16) | icmsg_minor;
> +
> +	negop->icversion_data[0].major =3D icframe_major;
> +	negop->icversion_data[0].minor =3D icframe_minor;
> +	negop->icversion_data[1].major =3D icmsg_major;
> +	negop->icversion_data[1].minor =3D icmsg_minor;
> +
> +	return found_match;
> +}
> +
> +static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
> +{
> +	size_t len =3D 0;
> +
> +	while (len < dest_size) {
> +		if (src[len] < 0x80)
> +			dest[len++] =3D (char)(*src++);
> +		else
> +			dest[len++] =3D 'X';
> +	}
> +
> +	dest[len] =3D '\0';
> +}
> +
> +static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
> +{
> +	setlocale(LC_ALL, "en_US.utf8");
> +	size_t file_size, path_size;
> +	char *file_name, *path_name;
> +	char *in_file_name =3D (char *)smsg_in->file_name;
> +	char *in_path_name =3D (char *)smsg_in->path_name;
> +
> +	file_size =3D wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) =
+ 1;
> +	path_size =3D wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) =
+ 1;
> +
> +	file_name =3D (char *)malloc(file_size * sizeof(char));
> +	path_name =3D (char *)malloc(path_size * sizeof(char));
> +
> +	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
> +	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
> +
> +	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
> +}
> +
> +static int hv_fcopy_send_data(struct hv_fcopy_hdr *fcopy_msg, int recvle=
n)
> +{
> +	int operation =3D fcopy_msg->operation;
> +
> +	/*
> +	 * The  strings sent from the host are encoded in
> +	 * utf16; convert it to utf8 strings.
> +	 * The host assures us that the utf16 strings will not exceed
> +	 * the max lengths specified. We will however, reserve room
> +	 * for the string terminating character - in the utf16s_utf8s()
> +	 * function we limit the size of the buffer where the converted
> +	 * string is placed to W_MAX_PATH -1 to guarantee
> +	 * that the strings can be properly terminated!
> +	 */
> +
> +	switch (operation) {
> +	case START_FILE_COPY:
> +		return hv_fcopy_start((struct hv_start_fcopy *)fcopy_msg);
> +	case WRITE_TO_FILE:
> +		return hv_copy_data((struct hv_do_fcopy *)fcopy_msg);
> +	case COMPLETE_FCOPY:
> +		return hv_copy_finished();
> +	}
> +
> +	return HV_E_FAIL;
> +}
> +
> +/* process the packet recv from host */
> +static int fcopy_pkt_process(struct vmbus_br *txbr)
> +{
> +	int ret, offset, pktlen;
> +	int fcopy_srv_version;
> +	const struct vmbus_chanpkt_hdr *pkt;
> +	struct hv_fcopy_hdr *fcopy_msg;
> +	struct icmsg_hdr *icmsghdr;
> +
> +	pkt =3D (const struct vmbus_chanpkt_hdr *)desc;
> +	offset =3D pkt->hlen << 3;
> +	pktlen =3D (pkt->tlen << 3) - offset;
> +	icmsghdr =3D (struct icmsg_hdr *)&desc[offset + sizeof(struct vmbuspipe=
_hdr)];
> +	icmsghdr->status =3D HV_E_FAIL;
> +
> +	if (icmsghdr->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {
> +		if (vmbus_prep_negotiate_resp(icmsghdr, desc + offset, pktlen, fw_vers=
ions,
> +					      FW_VER_COUNT, fcopy_versions, FCOPY_VER_COUNT,
> +					      NULL, &fcopy_srv_version)) {
> +			syslog(LOG_INFO, "FCopy IC version %d.%d",
> +			       fcopy_srv_version >> 16, fcopy_srv_version & 0xFFFF);
> +			icmsghdr->status =3D 0;
> +		}
> +	} else if (icmsghdr->icmsgtype =3D=3D ICMSGTYPE_FCOPY) {
> +		/* Ensure recvlen is big enough to contain hv_fcopy_hdr */
> +		if (pktlen < ICMSG_HDR + sizeof(struct hv_fcopy_hdr)) {
> +			syslog(LOG_ERR, "Invalid Fcopy hdr. Packet length too small: %u",
> +			       pktlen);
> +			return -ENOBUFS;
> +		}
> +
> +		fcopy_msg =3D (struct hv_fcopy_hdr *)&desc[offset + ICMSG_HDR];
> +		icmsghdr->status =3D hv_fcopy_send_data(fcopy_msg, pktlen);
> +	}
> +
> +	icmsghdr->icflags =3D ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
> +	ret =3D rte_vmbus_chan_send(txbr, 0x6, desc + offset, pktlen, 0);
> +	if (ret) {
> +		syslog(LOG_ERR, "Write to ringbuffer failed err: %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fcopy_get_first_folder(char *path, char *chan_no)
> +{
> +	DIR *dir =3D opendir(path);
> +	struct dirent *entry;
> +
> +	if (!dir) {
> +		syslog(LOG_ERR, "Failed to open directory (errno=3D%s).\n", strerror(e=
rrno));
> +		return;
> +	}
> +
> +	while ((entry =3D readdir(dir)) !=3D NULL) {
> +		if (entry->d_type =3D=3D DT_DIR && strcmp(entry->d_name, ".") !=3D 0 &=
&
> +		    strcmp(entry->d_name, "..") !=3D 0) {
> +			strcpy(chan_no, entry->d_name);
> +			break;
> +		}
> +	}
> +
> +	closedir(dir);
> +}
> +
> +static void fcopy_set_ring_size(char *path, char *inst, int size)
> +{
> +	char ring_size_path[MAX_PATH_LEN] =3D {0};
> +	FILE *fd;
> +
> +	snprintf(ring_size_path, sizeof(ring_size_path), "%s/%s/%s", path, inst=
, "ring_size");
> +	fd =3D fopen(ring_size_path, "w");
> +	if (!fd) {
> +		syslog(LOG_WARNING, "Failed to open ring_size file (errno=3D%s).\n", s=
trerror(errno));
> +		return;
> +	}
> +	fprintf(fd, "%d", size);

Check for and log an error if the new value isn't accepted by the kernel dr=
iver?
The code is using a ring size value that should be accepted by the kernel d=
river,
but weird stuff happens and it's probably better to know about it.

> +	fclose(fd);
> +}
> +
> +static char *fcopy_read_sysfs(char *path, char *buf, int len)
> +{
> +	FILE *fd;
> +	char *ret;
> +
> +	fd =3D fopen(path, "r");
> +	if (!fd)
> +		return NULL;
> +
> +	ret =3D fgets(buf, len, fd);
> +	fclose(fd);
> +
> +	return ret;
> +}
> +
> +static int fcopy_get_instance_id(char *path, char *class_id, char *inst)
> +{
> +	DIR *dir =3D opendir(path);
> +	struct dirent *entry;
> +	char tmp_path[MAX_PATH_LEN] =3D {0};
> +	char line[MAX_LINE_LEN];
> +
> +	if (!dir) {
> +		syslog(LOG_ERR, "Failed to open directory (errno=3D%s).\n", strerror(e=
rrno));
> +		return -EINVAL;
> +	}
> +
> +	while ((entry =3D readdir(dir)) !=3D NULL) {
> +		if (entry->d_type =3D=3D DT_LNK && strcmp(entry->d_name, ".") !=3D 0 &=
&
> +		    strcmp(entry->d_name, "..") !=3D 0) {
> +			/* search for the sysfs path with matching class_id */
> +			snprintf(tmp_path, sizeof(tmp_path), "%s/%s/%s",
> +				 path, entry->d_name, "class_id");
> +			if (!fcopy_read_sysfs(tmp_path, line, MAX_LINE_LEN))
> +				continue;
> +
> +			/* class id matches, now fetch the instance id from device_id */
> +			if (strstr(line, class_id)) {
> +				snprintf(tmp_path, sizeof(tmp_path), "%s/%s/%s",
> +					 path, entry->d_name, "device_id");
> +				if (!fcopy_read_sysfs(tmp_path, line, MAX_LINE_LEN))
> +					continue;
> +				/* remove braces */
> +				strncpy(inst, line + 1, strlen(line) - 3);
> +				break;
> +			}
> +		}
> +	}
> +
> +	closedir(dir);
> +	return 0;

If this function doesn't find a matching class_id, it appears that it
returns 0, but with the "inst" parameter unset.  The caller will then
proceed as if "inst" was set when it is actually an uninitialized stack
variable.  Probably need some better error detection and handling.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int fcopy_fd =3D -1, tmp =3D 1;
> +	int daemonize =3D 1, long_index =3D 0, opt, ret =3D -EINVAL;
> +	struct vmbus_br txbr, rxbr;
> +	void *ring;
> +	uint32_t len =3D HV_RING_SIZE;
> +	char uio_name[10] =3D {0};
> +	char uio_dev_path[15] =3D {0};
> +	char uio_path[MAX_PATH_LEN] =3D {0};
> +	char inst[MAX_LINE_LEN] =3D {0};
> +
> +	static struct option long_options[] =3D {
> +		{"help",	no_argument,	   0,  'h' },
> +		{"no-daemon",	no_argument,	   0,  'n' },
> +		{0,		0,		   0,  0   }
> +	};
> +
> +	while ((opt =3D getopt_long(argc, argv, "hn", long_options,
> +				  &long_index)) !=3D -1) {
> +		switch (opt) {
> +		case 'n':
> +			daemonize =3D 0;
> +			break;
> +		case 'h':
> +		default:
> +			print_usage(argv);
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
> +	if (daemonize && daemon(1, 0)) {
> +		syslog(LOG_ERR, "daemon() failed; error: %s", strerror(errno));
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	openlog("HV_UIO_FCOPY", 0, LOG_USER);
> +	syslog(LOG_INFO, "starting; pid is:%d", getpid());
> +
> +	/* get instance id */
> +	if (fcopy_get_instance_id(DEVICES_SYSFS, FCOPY_CLASS_ID, inst))
> +		exit(EXIT_FAILURE);

Per above, need better error handling.  And since the syslog is now open,
any errors should be logged rather than having the process just
mysteriously exit.

> +
> +	/* set ring_size value */
> +	fcopy_set_ring_size(DEVICES_SYSFS, inst, HV_RING_SIZE);
> +
> +	/* get /dev/uioX dev path and open it */
> +	snprintf(uio_path, sizeof(uio_path), "%s/%s/%s", DEVICES_SYSFS, inst, "=
uio");
> +	fcopy_get_first_folder(uio_path, uio_name);
> +	snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
> +	fcopy_fd =3D open(uio_dev_path, O_RDWR);
> +
> +	if (fcopy_fd < 0) {
> +		syslog(LOG_ERR, "open %s failed; error: %d %s",
> +		       uio_dev_path, errno, strerror(errno));
> +		syslog(LOG_ERR, "Please make sure module uio_hv_vmbus_client is loaded=
 and" \
> +		       " device is not used by any other application\n");
> +		ret =3D fcopy_fd;
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ring =3D mmap(NULL, 2 * HV_RING_SIZE, PROT_READ | PROT_WRITE, MAP_SHARE=
D, fcopy_fd, 0);
> +	if (ring =3D=3D MAP_FAILED) {
> +		ret =3D errno;
> +		syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret, strerror(=
ret));
> +		goto close;
> +	}
> +	vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
> +	vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
> +
> +	while (1) {
> +		/*
> +		 * In this loop we process fcopy messages after the
> +		 * handshake is complete.
> +		 */
> +		ret =3D pread(fcopy_fd, &tmp, sizeof(int), 0);
> +		if (ret < 0) {
> +			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
> +			continue;
> +		}
> +
> +		len =3D HV_RING_SIZE;
> +		ret =3D rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
> +		if (unlikely(ret <=3D 0)) {
> +			/* This indicates a failure to communicate (or worse) */
> +			syslog(LOG_ERR, "VMBus channel recv error: %d", ret);
> +		} else {
> +			ret =3D fcopy_pkt_process(&txbr);
> +			if (ret < 0)
> +				goto close;
> +
> +			/* Signal host */
> +			tmp =3D 1;
> +			if ((write(fcopy_fd, &tmp, sizeof(int))) !=3D sizeof(int)) {
> +				ret =3D errno;
> +				syslog(LOG_ERR, "Registration failed: %s\n", strerror(ret));
> +				goto close;
> +			}
> +		}
> +	}
> +close:
> +	close(fcopy_fd);
> +	return ret;
> +}
> --
> 2.34.1

