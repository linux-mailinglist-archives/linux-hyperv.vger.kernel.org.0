Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9482F2FF4
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 14:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfKGNjT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 08:39:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733250AbfKGNjS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 08:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tq2JeUBVUQ/XsuBt3nC8IiPmPbwKvnLljLM+JcrAMJk=;
        b=KMNY2d8aZwBcqGuLQVwZMWK5L2y8WMKXk5SSK2uvfi/LLOa4rnDOSoH4nXz8nidHG6x1NW
        03KKNd0OUA7hRM6bakJDUfBHtdZZONhMJQsoCKsAcAP096pXZLW9btoYn+Khzvp9vPwQNl
        4lu/4KxhjDCIpCf6Z8VARoBwVOBzhMI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-_j0K6LTXMSaOKLNFKzQ62w-1; Thu, 07 Nov 2019 08:39:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id u2so1034906wrm.7
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2019 05:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R0mNyYZd6bScGehmpEaPxSSN+C3Fm91zz0KVrfqWw10=;
        b=LtISec7dcHxMEPjwnSX/8gTh4CAzZGN4EShbCHEQSC9wfl9LQGoYASn+Noz39SKmh/
         DwWs6UkjhyxaL8c7tWZxBsUEMTGikpyCmnpRdvnsL3YOXnEM8Q8K+ztndE12g9pAr9+B
         bLE28tdWme4+XeAZa8W4W7xbTAoBI8iIdJtnPtVLGLU7FM1t47O/nDI5wIeTPg8Zs4eu
         nWKAYdgws2JPzDwi44pNrGut49twnXTDwQ8S0aTKNdUFBrGWsU6R7AFcWS3x64U5ysVE
         JBfLMcPyvRDJRwan2EGBVmhqI7kqMO53Z80buSl5b2tLOWIoJSRrizZG1RQRvDwaXvnk
         IHTg==
X-Gm-Message-State: APjAAAXMglv4QATEWvFSfuEMMUlc/ipCaha5Ggt61QhX9A2d99HFBsYS
        EJdJyEIz2LY3fUUI0bppbwi+Z+/X4RFFSC3okTl9qxxkkL+YusH0AbhuyvLjsq3n9rTNdnJ2+iR
        SamREGHI9t9hIBbC3dVagzwo1
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr3011982wrx.394.1573133953385;
        Thu, 07 Nov 2019 05:39:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlJH4U7SHbrC8hxVGAeT6H8Xo6YW+iuKy+hdOOvg2QwqKGRTGrF+FvXRmJs1SP18+ynLahVA==
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr3011954wrx.394.1573133953071;
        Thu, 07 Nov 2019 05:39:13 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c15sm1843353wmb.45.2019.11.07.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:39:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
In-Reply-To: <20191024144943.26199-1-olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de>
Date:   Thu, 07 Nov 2019 14:39:11 +0100
Message-ID: <874kzfbybk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: _j0K6LTXMSaOKLNFKzQ62w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> The hostname is resolved just once since commit 58125210ab3b ("Tools:
> hv: cache FQDN in kvp_daemon to avoid timeouts") to make sure the VM
> responds within the timeout limits to requests from the host.
>
> If for some reason getaddrinfo fails, the string returned by the
> "FullyQualifiedDomainName" request contains some error string, which is
> then used by tools on the host side.
>
> Adjust the code to resolve the current hostname in a separate thread.
> This thread loops until getaddrinfo returns success. During this time
> all "FullyQualifiedDomainName" requests will be answered with an empty
> string.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  tools/hv/Makefile        |  2 ++
>  tools/hv/hv_kvp_daemon.c | 69 ++++++++++++++++++++++++++++++++----------=
------
>  2 files changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index b57143d9459c..3b5481015a84 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -22,6 +22,8 @@ ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS=
))
> =20
>  ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.=
sh
> =20
> +$(OUTPUT)hv_kvp_daemon: LDFLAGS +=3D -lpthread
> +
>  all: $(ALL_PROGRAMS)
> =20
>  export srctree OUTPUT CC LD CFLAGS
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index e9ef4ca6a655..22cf1c4dbf5c 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -41,6 +41,7 @@
>  #include <net/if.h>
>  #include <limits.h>
>  #include <getopt.h>
> +#include <pthread.h>
> =20
>  /*
>   * KVP protocol: The user mode component first registers with the
> @@ -85,7 +86,7 @@ static char *processor_arch;
>  static char *os_build;
>  static char *os_version;
>  static char *lic_version =3D "Unknown version";
> -static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
> +static char *full_domain_name;
>  static struct utsname uts_buf;
> =20
>  /*
> @@ -1327,27 +1328,53 @@ static int kvp_set_ip_info(char *if_name, struct =
hv_kvp_ipaddr_value *new_val)
>  =09return error;
>  }
> =20
> -
> -static void
> -kvp_get_domain_name(char *buffer, int length)
> +/*
> + * Async retrival of Fully Qualified Domain Name because getaddrinfo tak=
es an
> + * unpredictable amount of time to finish.
> + */
> +static void *kvp_getaddrinfo(void *p)
>  {
> -=09struct addrinfo=09hints, *info ;
> -=09int error =3D 0;
> +=09char *tmp, **str_ptr =3D (char **)p;
> +=09char hostname[HOST_NAME_MAX + 1];
> +=09struct addrinfo=09*info, hints =3D {
> +=09=09.ai_family =3D AF_INET, /* Get only ipv4 addrinfo. */
> +=09=09.ai_socktype =3D SOCK_STREAM,
> +=09=09.ai_flags =3D AI_CANONNAME,
> +=09};
> +=09int ret;
> +
> +=09if (gethostname(hostname, sizeof(hostname) - 1) < 0)
> +=09=09goto out;
> +
> +=09do {
> +=09=09ret =3D getaddrinfo(hostname, NULL, &hints, &info);
> +=09=09if (ret)
> +=09=09=09sleep(1);

Is it only EAI_AGAIN or do you see any other return values which justify
the retry? I'm afraid that in case of a e.g. non-existing hostname we'll
be infinitely looping with EAI_FAIL.

> +=09} while (ret);
> +
> +=09ret =3D asprintf(&tmp, "%s", info->ai_canonname);
> +=09freeaddrinfo(info);
> +=09if (ret <=3D 0)
> +=09=09goto out;
> +
> +=09if (ret > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)
> +=09=09tmp[HV_KVP_EXCHANGE_MAX_VALUE_SIZE - 1] =3D '\0';
> +=09*str_ptr =3D tmp;
> =20
> -=09gethostname(buffer, length);
> -=09memset(&hints, 0, sizeof(hints));
> -=09hints.ai_family =3D AF_INET; /*Get only ipv4 addrinfo. */
> -=09hints.ai_socktype =3D SOCK_STREAM;
> -=09hints.ai_flags =3D AI_CANONNAME;
> +out:
> +=09pthread_exit(NULL);
> +}
> +
> +static void kvp_obtain_domain_name(char **str_ptr)
> +{
> +=09pthread_t t;
> =20
> -=09error =3D getaddrinfo(buffer, NULL, &hints, &info);
> -=09if (error !=3D 0) {
> -=09=09snprintf(buffer, length, "getaddrinfo failed: 0x%x %s",
> -=09=09=09error, gai_strerror(error));
> +=09if (pthread_create(&t, NULL, kvp_getaddrinfo, str_ptr)) {
> +=09=09syslog(LOG_ERR, "pthread_create failed; error: %d %s",
> +=09=09=09errno, strerror(errno));
>  =09=09return;
>  =09}
> -=09snprintf(buffer, length, "%s", info->ai_canonname);
> -=09freeaddrinfo(info);
> +=09pthread_detach(t);

I think this should be complemented with pthread_cancel/pthread_join
before exiting main().

>  }
> =20
>  void print_usage(char *argv[])
> @@ -1412,11 +1439,7 @@ int main(int argc, char *argv[])
>  =09 * Retrieve OS release information.
>  =09 */
>  =09kvp_get_os_info();
> -=09/*
> -=09 * Cache Fully Qualified Domain Name because getaddrinfo takes an
> -=09 * unpredictable amount of time to finish.
> -=09 */
> -=09kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
> +=09kvp_obtain_domain_name(&full_domain_name);
> =20
>  =09if (kvp_file_init()) {
>  =09=09syslog(LOG_ERR, "Failed to initialize the pools");
> @@ -1571,7 +1594,7 @@ int main(int argc, char *argv[])
> =20
>  =09=09switch (hv_msg->body.kvp_enum_data.index) {
>  =09=09case FullyQualifiedDomainName:
> -=09=09=09strcpy(key_value, full_domain_name);
> +=09=09=09strcpy(key_value, full_domain_name ? : "");
>  =09=09=09strcpy(key_name, "FullyQualifiedDomainName");
>  =09=09=09break;
>  =09=09case IntegrationServicesVersion:

--=20
Vitaly

