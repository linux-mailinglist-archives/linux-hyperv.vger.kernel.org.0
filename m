Return-Path: <linux-hyperv+bounces-522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20C7C8224
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Oct 2023 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D3C282241
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Oct 2023 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBB1118E;
	Fri, 13 Oct 2023 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNCuJepm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6F11187
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Oct 2023 09:37:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19950B7
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Oct 2023 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697189818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnfceKfpnNfioFfuyj/sLNue74yevcvUBw1BegkkoUI=;
	b=WNCuJepmjBrbp4u3efHuQR+epWMpr5WOYLdaiBWt4LRGGeIZgDg8sY1Fhi+2e36Lw1zBne
	pum9dywTlAuFv488+ktaNXAEPssQWyv0bLShugLrdBn+7G4Qd/eYJdw8OSq5GJT5sT2X74
	pQ5l3Y8gtl+4T4tAZ6/aNXepvp2TLYY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-U4_oPBVYOqWLURR0PgJ4Jg-1; Fri, 13 Oct 2023 05:36:56 -0400
X-MC-Unique: U4_oPBVYOqWLURR0PgJ4Jg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-690c2fec489so1538256b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Oct 2023 02:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189816; x=1697794616;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnfceKfpnNfioFfuyj/sLNue74yevcvUBw1BegkkoUI=;
        b=tODum3l0PnApI5EzN8BiEcx2oSReMWtLYaAfTLU25EmczUWU4EMUPob4DTsGTH5Lxu
         j9z9bQ5atBdQ/kph9wJxWbISujgU84MVURcvNutxrRJb6IgoeRrIRSTrDJuwAQR5+s09
         2MhgbqMW9vahpcjgeaKl6z8Vzkva8aLsJXhlSRCcEn7RTGBgAkvv6mXxGcPz6ZzY23cu
         bAjIUcikQlRTi1i8EyNcDrphQ45MaDlMN/s9yIF9dusokE8B96D7FGFZ5TRg7O3dJF8H
         stF54ufaV5b1UYhFFYTWQ5lgJ/PYXSJIaRBdrxa+J0udrHMnHajpLyqWNwVI9wC5sm4Y
         BfBQ==
X-Gm-Message-State: AOJu0YwJLyzTbTH6sMpMKZIShDc4QZqdowI9QY0wRNDZgqjGGqcg3s3O
	KMcGSPE7B3dB2Gp1GTiamlJpxnI3j5TLEqn/g8r8dGvRl40ZfaQCITkV85ANz2k4IF11Q4nV5pm
	ZzoDVEB7VEqHkdJQG5m60PF1N
X-Received: by 2002:a05:6a20:7f83:b0:15e:b8a1:57b9 with SMTP id d3-20020a056a207f8300b0015eb8a157b9mr32606683pzj.24.1697189815714;
        Fri, 13 Oct 2023 02:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNAtCdhbEudvQa8D2rhwFTN/N7q/afDX/TXVDKgjUht/qcfb5IeKz8YZTW0kHGb5nUx7gasw==
X-Received: by 2002:a05:6a20:7f83:b0:15e:b8a1:57b9 with SMTP id d3-20020a056a207f8300b0015eb8a157b9mr32606664pzj.24.1697189815259;
        Fri, 13 Oct 2023 02:36:55 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.235])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c5076ae6absm3423217plb.126.2023.10.13.02.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:36:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection
 profile
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Fri, 13 Oct 2023 15:06:46 +0530
Cc: linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>,
 Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 09-Oct-2023, at 4:08 PM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> Ifcfg config file support in NetworkManger is deprecated. This patch
> provides support for the new keyfile config format for connection
> profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> to generate the new network configuration in keyfile
> format(.ini-style format) along with a ifcfg format configuration.
> The ifcfg format configuration is also retained to support easy
> backward compatibility for distro vendors. These configurations are
> stored in temp files which are further translated using the
> hv_set_ifconfig.sh script. This script is implemented by individual
> distros based on the network management commands supported.
> For example, RHEL's implementation could be found here:
> =
https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_s=
et_ifconfig.sh
> Debian's implementation could be found here:
> =
https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_if=
config
>=20
> The next part of this support is to let the Distro vendors consume
> these modified implementations to the new configuration format.
>=20
> Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)

Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 =
addresses in ipv6 section:

]# cat eth0.nmconnection=20

[connection]
autoconnect=3Dyes
interface-name=3Deth0

[ethernet]
mac-address=3D00:15:5D:C4:63:45

[ipv6]
method=3Dmanual
address=3D1234:1234:1234:1234:0000:0000:0000:0113/120
gateway=3D10.73.199.254
dns=3D10.72.17.5

Gateway and dns should be in ipv6.=20

Ipv4 dns addresses comes from /etc/resolv.conf and in our system:

# /usr/libexec/hypervkvpd/hv_get_dns_info
10.72.17.5
10.68.5.26

[root@vm-197-248 ~]# cat /etc/resolv.conf=20
# Generated by NetworkManager
search lab.eng.pek2.redhat.com
nameserver 10.72.17.5
nameserver 10.68.5.26

So we should check if the addresses are indeed ipv6 or not and should =
not print it if !is_ipv4(). Ipv6 addresses may not be provisioned.

I will post a patch fix when we complete our internal testing.


> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> Changes v7->v8
> * Fix some filename variable names to avoid confusion
> * Add initialization of is_ipv6 variable
> * Add a few comments
> ---
> tools/hv/hv_kvp_daemon.c    | 233 +++++++++++++++++++++++++++++++-----
> tools/hv/hv_set_ifconfig.sh |  39 +++++-
> 2 files changed, 235 insertions(+), 37 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 27f5e7dfc2f7..264eeb9c46a9 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -1171,12 +1171,79 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
> 	return 0;
> }
>=20
> +/*
> + * Only IPv4 subnet strings needs to be converted to plen
> + * For IPv6 the subnet is already privided in plen format
> + */
> +static int kvp_subnet_to_plen(char *subnet_addr_str)
> +{
> +	int plen =3D 0;
> +	struct in_addr subnet_addr4;
> +
> +	/*
> +	 * Convert subnet address to binary representation
> +	 */
> +	if (inet_pton(AF_INET, subnet_addr_str, &subnet_addr4) =3D=3D 1) =
{
> +		uint32_t subnet_mask =3D ntohl(subnet_addr4.s_addr);
> +
> +		while (subnet_mask & 0x80000000) {
> +			plen++;
> +			subnet_mask <<=3D 1;
> +		}
> +	} else {
> +		return -1;
> +	}
> +
> +	return plen;
> +}
> +
> +static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
> +				int is_ipv6)
> +{
> +	char addr[INET6_ADDRSTRLEN];
> +	char subnet_addr[INET6_ADDRSTRLEN];
> +	int error, i =3D 0;

This should be initialised to 1

=
https://developer-old.gnome.org/NetworkManager/stable/nm-settings-keyfile.=
html#:~:text=3DFile%20Format,%2Dsettings(5)).

Also see below.

> +	int ip_offset =3D 0, subnet_offset =3D 0;
> +	int plen;
> +
> +	memset(addr, 0, sizeof(addr));
> +	memset(subnet_addr, 0, sizeof(subnet_addr));
> +
> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +				   (MAX_IP_ADDR_SIZE * 2)) &&
> +				   parse_ip_val_buffer(subnet,
> +						       &subnet_offset,
> +						       subnet_addr,
> +						       (MAX_IP_ADDR_SIZE =
*
> +							2))) {
> +		if (!is_ipv6)
> +			plen =3D kvp_subnet_to_plen((char =
*)subnet_addr);
> +		else
> +			plen =3D atoi(subnet_addr);
> +
> +		if (plen < 0)
> +			return plen;
> +
> +		error =3D fprintf(f, "address%d=3D%s/%d\n", ++i, (char =
*)addr,
> +				plen);
> +		if (error < 0)
> +			return error;
> +
> +		memset(addr, 0, sizeof(addr));
> +		memset(subnet_addr, 0, sizeof(subnet_addr));
> +	}
> +
> +	return 0;
> +}
> +
> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
> {
> 	int error =3D 0;
> -	char if_file[PATH_MAX];
> -	FILE *file;
> +	char if_filename[PATH_MAX];
> +	char nm_filename[PATH_MAX];
> +	FILE *ifcfg_file, *nmfile;
> 	char cmd[PATH_MAX];
> +	int is_ipv6 =3D 0;
> 	char *mac_addr;
> 	int str_len;
>=20
> @@ -1197,7 +1264,7 @@ static int kvp_set_ip_info(char *if_name, struct =
hv_kvp_ipaddr_value *new_val)
> 	 * in a given distro to configure the interface and so are free
> 	 * ignore information that may not be relevant.
> 	 *
> -	 * Here is the format of the ip configuration file:
> +	 * Here is the ifcfg format of the ip configuration file:
> 	 *
> 	 * HWADDR=3Dmacaddr
> 	 * DEVICE=3Dinterface name
> @@ -1220,6 +1287,32 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> 	 * tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
> 	 * IPV6NETMASK.
> 	 *
> +	 * Here is the keyfile format of the ip configuration file:
> +	 *
> +	 * [ethernet]
> +	 * mac-address=3Dmacaddr
> +	 * [connection]
> +	 * interface-name=3Dinterface name
> +	 *
> +	 * [ipv4]
> +	 * method=3D<protocol> (where <protocol> is "auto" if DHCP is =
configured
> +	 *                       or "manual" if no boot-time protocol =
should be used)
> +	 *
> +	 * address1=3Dipaddr1/plen
> +	 * address2=3Dipaddr2/plen
> +	 *
> +	 * gateway=3Dgateway1;gateway2
> +	 *
> +	 * dns=3Ddns1;dns2
> +	 *
> +	 * [ipv6]
> +	 * address1=3Dipaddr1/plen
> +	 * address2=3Dipaddr2/plen
> +	 *
> +	 * gateway=3Dgateway1;gateway2
> +	 *
> +	 * dns=3Ddns1;dns2
> +	 *
> 	 * The host can specify multiple ipv4 and ipv6 addresses to be
> 	 * configured for the interface. Furthermore, the configuration
> 	 * needs to be persistent. A subsequent GET call on the =
interface
> @@ -1227,14 +1320,29 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> 	 * call.
> 	 */
>=20
> -	snprintf(if_file, sizeof(if_file), "%s%s%s", KVP_CONFIG_LOC,
> -		"/ifcfg-", if_name);
> +	/*
> +	 * We are populating both ifcfg and nmconnection files
> +	 */
> +	snprintf(if_filename, sizeof(if_filename), "%s%s%s", =
KVP_CONFIG_LOC,
> +		 "/ifcfg-", if_name);
>=20
> -	file =3D fopen(if_file, "w");
> +	ifcfg_file =3D fopen(if_filename, "w");
>=20
> -	if (file =3D=3D NULL) {
> +	if (!ifcfg_file) {
> 		syslog(LOG_ERR, "Failed to open config file; error: %d =
%s",
> -				errno, strerror(errno));
> +		       errno, strerror(errno));
> +		return HV_E_FAIL;
> +	}
> +
> +	snprintf(nm_filename, sizeof(nm_filename), "%s%s%s%s", =
KVP_CONFIG_LOC,
> +		 "/", if_name, ".nmconnection");
> +
> +	nmfile =3D fopen(nm_filename, "w");
> +
> +	if (!nmfile) {
> +		syslog(LOG_ERR, "Failed to open config file; error: %d =
%s",
> +		       errno, strerror(errno));
> +		fclose(ifcfg_file);
> 		return HV_E_FAIL;
> 	}
>=20
> @@ -1248,14 +1356,31 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> 		goto setval_error;
> 	}
>=20
> -	error =3D kvp_write_file(file, "HWADDR", "", mac_addr);
> -	free(mac_addr);
> +	error =3D kvp_write_file(ifcfg_file, "HWADDR", "", mac_addr);
> +	if (error < 0)
> +		goto setmac_error;
> +
> +	error =3D kvp_write_file(ifcfg_file, "DEVICE", "", if_name);
> +	if (error < 0)
> +		goto setmac_error;
> +
> +	error =3D fprintf(nmfile, "\n[connection]\n");
> +	if (error < 0)
> +		goto setmac_error;
> +
> +	error =3D kvp_write_file(nmfile, "interface-name", "", if_name);
> 	if (error)
> -		goto setval_error;
> +		goto setmac_error;
>=20
> -	error =3D kvp_write_file(file, "DEVICE", "", if_name);
> +	error =3D fprintf(nmfile, "\n[ethernet]\n");
> +	if (error < 0)
> +		goto setmac_error;
> +
> +	error =3D kvp_write_file(nmfile, "mac-address", "", mac_addr);
> 	if (error)
> -		goto setval_error;
> +		goto setmac_error;
> +
> +	free(mac_addr);
>=20
> 	/*
> 	 * The dhcp_enabled flag is only for IPv4. In the case the host =
only
> @@ -1263,47 +1388,91 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> 	 * proceed to parse and pass the IPv6 information to the
> 	 * disto-specific script hv_set_ifconfig.
> 	 */
> +
> +	/*
> +	 * First populate the ifcfg file format
> +	 */
> 	if (new_val->dhcp_enabled) {
> -		error =3D kvp_write_file(file, "BOOTPROTO", "", "dhcp");
> +		error =3D kvp_write_file(ifcfg_file, "BOOTPROTO", "", =
"dhcp");
> 		if (error)
> 			goto setval_error;
> -
> 	} else {
> -		error =3D kvp_write_file(file, "BOOTPROTO", "", "none");
> +		error =3D kvp_write_file(ifcfg_file, "BOOTPROTO", "", =
"none");
> 		if (error)
> 			goto setval_error;
> 	}
>=20
> -	/*
> -	 * Write the configuration for ipaddress, netmask, gateway and
> -	 * name servers.
> -	 */
> -
> -	error =3D process_ip_string(file, (char *)new_val->ip_addr, =
IPADDR);
> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->ip_addr,
> +				  IPADDR);
> 	if (error)
> 		goto setval_error;
>=20
> -	error =3D process_ip_string(file, (char *)new_val->sub_net, =
NETMASK);
> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->sub_net,
> +				  NETMASK);
> 	if (error)
> 		goto setval_error;
>=20
> -	error =3D process_ip_string(file, (char *)new_val->gate_way, =
GATEWAY);
> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->gate_way,
> +				  GATEWAY);
> 	if (error)
> 		goto setval_error;
>=20
> -	error =3D process_ip_string(file, (char *)new_val->dns_addr, =
DNS);
> +	error =3D process_ip_string(ifcfg_file, (char =
*)new_val->dns_addr, DNS);
> 	if (error)
> 		goto setval_error;
>=20
> -	fclose(file);
> +	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {

I think we should have done something like

new_val->addr_family & ADDR_FAMILY_IPV6 here.

> +		error =3D fprintf(nmfile, "\n[ipv6]\n");
> +		if (error < 0)
> +			goto setval_error;
> +		is_ipv6 =3D 1;
> +	} else {
> +		error =3D fprintf(nmfile, "\n[ipv4]\n");
> +		if (error < 0)
> +			goto setval_error;
> +	}
> +
> +	/*
> +	 * Now we populate the keyfile format
> +	 */
> +
> +	if (new_val->dhcp_enabled) {
> +		error =3D kvp_write_file(nmfile, "method", "", "auto");
> +		if (error < 0)
> +			goto setval_error;
> +	} else {
> +		error =3D kvp_write_file(nmfile, "method", "", =
"manual");
> +		if (error < 0)
> +			goto setval_error;
> +	}
> +
> +	/*
> +	 * Write the configuration for ipaddress, netmask, gateway and
> +	 * name services
> +	 */
> +	error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +				     (char *)new_val->sub_net, is_ipv6);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	fclose(nmfile);
> +	fclose(ifcfg_file);
>=20
> 	/*
> 	 * Now that we have populated the configuration file,
> 	 * invoke the external script to do its magic.
> 	 */
>=20
> -	str_len =3D snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
> -			   "hv_set_ifconfig", if_file);
> +	str_len =3D snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s =
%s",
> +			   "hv_set_ifconfig", if_filename, nm_filename);
> 	/*
> 	 * This is a little overcautious, but it's necessary to suppress =
some
> 	 * false warnings from gcc 8.0.1.
> @@ -1316,14 +1485,16 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>=20
> 	if (system(cmd)) {
> 		syslog(LOG_ERR, "Failed to execute cmd '%s'; error: %d =
%s",
> -				cmd, errno, strerror(errno));
> +		       cmd, errno, strerror(errno));
> 		return HV_E_FAIL;
> 	}
> 	return 0;
> -
> +setmac_error:
> +	free(mac_addr);
> setval_error:
> 	syslog(LOG_ERR, "Failed to write config file");
> -	fclose(file);
> +	fclose(ifcfg_file);
> +	fclose(nmfile);
> 	return error;
> }
>=20
> diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
> index d10fe35b7f25..ae5a7a8249a2 100755
> --- a/tools/hv/hv_set_ifconfig.sh
> +++ b/tools/hv/hv_set_ifconfig.sh
> @@ -18,12 +18,12 @@
> #
> # This example script is based on a RHEL environment.
> #
> -# Here is the format of the ip configuration file:
> +# Here is the ifcfg format of the ip configuration file:
> #
> # HWADDR=3Dmacaddr
> # DEVICE=3Dinterface name
> # BOOTPROTO=3D<protocol> (where <protocol> is "dhcp" if DHCP is =
configured
> -#                       or "none" if no boot-time protocol should be =
used)
> +# 			or "none" if no boot-time protocol should be =
used)
> #
> # IPADDR0=3Dipaddr1
> # IPADDR1=3Dipaddr2
> @@ -41,6 +41,32 @@
> # tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
> # IPV6NETMASK.
> #
> +# Here is the keyfile format of the ip configuration file:
> +#
> +# [ethernet]
> +# mac-address=3Dmacaddr
> +# [connection]
> +# interface-name=3Dinterface name
> +#
> +# [ipv4]
> +# method=3D<protocol> (where <protocol> is "auto" if DHCP is =
configured
> +#                       or "manual" if no boot-time protocol should =
be used)
> +#
> +# address1=3Dipaddr1/plen
> +# address=3Dipaddr2/plen

address2 here?

> +#
> +# gateway=3Dgateway1;gateway2
> +#
> +# dns=3Ddns1;
> +#
> +# [ipv6]
> +# address1=3Dipaddr1/plen
> +# address2=3Dipaddr1/plen

ipaddr2 ?

> +#
> +# gateway=3Dgateway1;gateway2
> +#
> +# dns=3Ddns1;dns2
> +#
> # The host can specify multiple ipv4 and ipv6 addresses to be
> # configured for the interface. Furthermore, the configuration
> # needs to be persistent. A subsequent GET call on the interface
> @@ -48,18 +74,19 @@
> # call.
> #
>=20
> -
> -
> echo "IPV6INIT=3Dyes" >> $1
> echo "NM_CONTROLLED=3Dno" >> $1
> echo "PEERDNS=3Dyes" >> $1
> echo "ONBOOT=3Dyes" >> $1
>=20
> -
> cp $1 /etc/sysconfig/network-scripts/
>=20
> +chmod 600 $2
> +interface=3D$(echo $2 | awk -F - '{ print $2 }')
> +filename=3D"${2##*/}"
> +
> +sed '/\[connection\]/a autoconnect=3Dtrue' $2 > =
/etc/NetworkManager/system-connections/${filename}
>=20
> -interface=3D$(echo $1 | awk -F - '{ print $2 }')
>=20
> /sbin/ifdown $interface 2>/dev/null
> /sbin/ifup $interface 2>/dev/null
> --=20
> 2.34.1
>=20


