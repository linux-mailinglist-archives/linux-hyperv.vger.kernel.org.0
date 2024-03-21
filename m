Return-Path: <linux-hyperv+bounces-1809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB35885C73
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D93B1C22A20
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083AA86640;
	Thu, 21 Mar 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eKn7hYk+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E086ACD;
	Thu, 21 Mar 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035910; cv=none; b=tH24z5hXEvvfvGyvApI0hcDVoPnTkwsw+a7bLgB3fRPbUzUrJo6+bhLQmB7TA/cnr75U7WBeAmAXBFNXvsb8qux7aeSPvkPP5jbq3KcdmgxJOUH2Lu2sxkTILlTNj8rVCKZ+XTkm63Yz3J7TiYxNHX2ipCk83fiAfmXgMiqJl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035910; c=relaxed/simple;
	bh=XRolXUbz/HQbzw+yfn9BPwRJo4PycuARrV0YMaB1s3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWf7BOxls2SIxJyhEMn8mtAKUKY/ZR9SRHhv2+iXiGYcXhO6HbUI2tbSCGkG7I7r41+y5YqrkIS7XQRjlX/umMl7hSfQOaIyQmb6XGKkPlDNrBJoUQnEq3IjTp6Dcpy4q6HkTDwh45ZTj4OmtL+9eTkvvq/BHZPXta5RacImNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eKn7hYk+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 506C820B74C0; Thu, 21 Mar 2024 08:45:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 506C820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711035908;
	bh=Rydhyk+OBBmiBPqDDx6Ad5LVDtXGYv55rW6oej+Pi3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKn7hYk+cVhZzjbl0Qij8Aqgad6vJnEI/Sf6XTPUcIa5BJEWNb0nfU+T/sMTYF1fn
	 zbXsgQ1zUBxvj/0vtyqXEw0xTWprImP/mOot2cJJZhxAAzhLUQ1z7LNf5URXBiQAbH
	 l2CJtD9mVkVOcU5erPeZjjMZca2FnDmTp5ypsUjc=
Date: Thu, 21 Mar 2024 08:45:08 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <20240321154508.GA13704@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com>
 <A940B76F-8409-4147-8C09-DB2B3FD2EAF5@redhat.com>
 <0aef5a81-8b8c-6165-d05d-77c9cf639ebd@redhat.com>
 <20240321131042.GA2731@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <94FF7ECA-9D84-4626-BD72-EB0530AE22DC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94FF7ECA-9D84-4626-BD72-EB0530AE22DC@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 21, 2024 at 08:29:58PM +0530, Ani Sinha wrote:
> 
> 
> > On 21 Mar 2024, at 18:40, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> > 
> > On Thu, Mar 21, 2024 at 05:36:05PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >> On Thu, 21 Mar 2024, Ani Sinha wrote:
> >> 
> >>> 
> >>> 
> >>>> On 21 Mar 2024, at 09:25, Ani Sinha <anisinha@redhat.com> wrote:
> >>>> 
> >>>> 
> >>>> 
> >>>>> On 20 Mar 2024, at 16:47, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> >>>>> 
> >>>>> If the network configuration strings are passed as a combination of IPv4
> >>>>> and IPv6 addresses, the current KVP daemon does not handle processing for
> >>>>> the keyfile configuration format.
> >>>>> With these changes, the keyfile config generation logic scans through the
> >>>>> list twice to generate IPv4 and IPv6 sections for the configuration files
> >>>>> to handle this support.
> >>>>> 
> >>>>> Testcases ran:Rhel 9, Hyper-V VMs
> >>>>>            (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> >>>>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >>>>> ---
> >>>>> Changes in v4
> >>>>> * Removed the unnecessary memset for addr in the start
> >>>>> * Added a comment to describe how we erase the last comma character
> >>>>> * Fixed some typos in the commit description
> >>>>> * While using strncat, skip copying the '\0' character.
> >>>>> ---
> >>>>> tools/hv/hv_kvp_daemon.c | 181 ++++++++++++++++++++++++++++++---------
> >>>>> 1 file changed, 140 insertions(+), 41 deletions(-)
> >>>>> 
> >>>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> >>>>> index 318e2dad27e0..d64d548a802f 100644
> >>>>> --- a/tools/hv/hv_kvp_daemon.c
> >>>>> +++ b/tools/hv/hv_kvp_daemon.c
> >>>>> @@ -76,6 +76,12 @@ enum {
> >>>>> DNS
> >>>>> };
> >>>>> 
> >>>>> +enum {
> >>>>> + IPV4 = 1,
> >>>>> + IPV6,
> >>>>> + IP_TYPE_MAX
> >>>>> +};
> >>>>> +
> >>>>> static int in_hand_shake;
> >>>>> 
> >>>>> static char *os_name = "";
> >>>>> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
> >>>>> 
> >>>>> #define MAX_FILE_NAME 100
> >>>>> #define ENTRIES_PER_BLOCK 50
> >>>>> +/*
> >>>>> + * Change this entry if the number of addresses increases in future
> >>>>> + */
> >>>>> +#define MAX_IP_ENTRIES 64
> >>>>> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
> >>>>> 
> >>>>> struct kvp_record {
> >>>>> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> >>>>> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
> >>>>> return 0;
> >>>>> }
> >>>>> 
> >>>>> +int ip_version_check(const char *input_addr)
> >>>>> +{
> >>>>> + struct in6_addr addr;
> >>>>> +
> >>>>> + if (inet_pton(AF_INET, input_addr, &addr))
> >>>>> + return IPV4;
> >>>>> + else if (inet_pton(AF_INET6, input_addr, &addr))
> >>>>> + return IPV6;
> >>>>> +
> >>>>> + return -EINVAL;
> >>>>> +}
> >>>>> +
> >>>>> /*
> >>>>> * Only IPv4 subnet strings needs to be converted to plen
> >>>>> * For IPv6 the subnet is already privided in plen format
> >>>>> @@ -1197,14 +1220,75 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
> >>>>> return plen;
> >>>>> }
> >>>>> 
> >>>>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> >>>>> +  int ip_sec)
> >>>>> +{
> >>>>> + char addr[INET6_ADDRSTRLEN], *output_str;
> >>>>> + int ip_offset = 0, error = 0, ip_ver;
> >>>>> + char *param_name;
> >>>>> +
> >>>>> + if (type == DNS)
> >>>>> + param_name = "dns";
> >>>>> + else if (type == GATEWAY)
> >>>>> + param_name = "gateway";
> >>>>> + else
> >>>>> + return -EINVAL;
> >>>>> +
> >>>>> + output_str = (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
> >>>>> + if (!output_str)
> >>>>> + return -ENOMEM;
> >>>>> +
> >>>>> + while (1) {
> >>>>> + memset(addr, 0, sizeof(addr));
> >>>>> +
> >>>>> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> >>>>> + (MAX_IP_ADDR_SIZE * 2)))
> >>>>> + break;
> >>>>> +
> >>>>> + ip_ver = ip_version_check(addr);
> >>>>> + if (ip_ver < 0)
> >>>>> + continue;
> >>>>> +
> >>>>> + if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> >>>>> +    (ip_ver == IPV6 && ip_sec == IPV6)) {
> >>>>> + /*
> >>>>> + * do a bound check to avoid out-of bound writes
> >>>>> + */
> >>>>> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
> >>>>> +    (strlen(addr) + 1)) {
> >>>>> + strncat(output_str, addr,
> >>>>> + OUTSTR_BUF_SIZE -
> >>>>> + strlen(output_str) - 1);
> >>>>> + strncat(output_str, ",",
> >>>>> + OUTSTR_BUF_SIZE -
> >>>>> + strlen(output_str) - 1);
> >>>>> + }
> >>>>> + } else {
> >>>>> + continue;
> >>>>> + }
> >>>>> + }
> >>>>> +
> >>>>> + if (strlen(output_str)) {
> >>>>> + /*
> >>>>> + * This is to get rid of that extra comma character
> >>>>> + * in the end of the string
> >>>>> + */
> >>>>> + output_str[strlen(output_str) - 1] = '\0';
> >>>>> + error = fprintf(f, "%s=%s\n", param_name, output_str);
> >>>>> + }
> >>>>> +
> >>>>> + free(output_str);
> >>>>> + return error;
> >>>>> +}
> >>>>> +
> >>>>> static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >>>>> - int is_ipv6)
> >>>>> + int ip_sec)
> >>>>> {
> >>>>> char addr[INET6_ADDRSTRLEN];
> >>>>> char subnet_addr[INET6_ADDRSTRLEN];
> >>>>> int error, i = 0;
> >>>>> int ip_offset = 0, subnet_offset = 0;
> >>>>> - int plen;
> >>>>> + int plen, ip_ver;
> >>>>> 
> >>>>> memset(addr, 0, sizeof(addr));
> >>>>> memset(subnet_addr, 0, sizeof(subnet_addr));
> >>>>> @@ -1216,10 +1300,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >>>>>     subnet_addr,
> >>>>>     (MAX_IP_ADDR_SIZE *
> >>>>> 2))) {
> >>>>> - if (!is_ipv6)
> >>>>> + ip_ver = ip_version_check(addr);
> >>>>> + if (ip_ver < 0)
> >>>>> + continue;
> >>>>> +
> >>>>> + if (ip_ver == IPV4 && ip_sec == IPV4)
> >>>>> plen = kvp_subnet_to_plen((char *)subnet_addr);
> >>>>> - else
> >>>>> + else if (ip_ver == IPV6 && ip_sec == IPV6)
> >>>>> plen = atoi(subnet_addr);
> >>>>> + else
> >>>>> + continue;
> >>>>> 
> >>>>> if (plen < 0)
> >>>>> return plen;
> >>>>> @@ -1238,12 +1328,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >>>>> 
> >>>>> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >>>>> {
> >>>>> - int error = 0;
> >>>>> + int error = 0, ip_ver;
> >>>>> char if_filename[PATH_MAX];
> >>>>> char nm_filename[PATH_MAX];
> >>>>> FILE *ifcfg_file, *nmfile;
> >>>>> char cmd[PATH_MAX];
> >>>>> - int is_ipv6 = 0;
> >>>>> char *mac_addr;
> >>>>> int str_len;
> >>>>> 
> >>>>> @@ -1421,52 +1510,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >>>>> if (error)
> >>>>> goto setval_error;
> >>>>> 
> >>>>> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> >>>>> - error = fprintf(nmfile, "\n[ipv6]\n");
> >>>>> - if (error < 0)
> >>>>> - goto setval_error;
> >>>>> - is_ipv6 = 1;
> >>>>> - } else {
> >>>>> - error = fprintf(nmfile, "\n[ipv4]\n");
> >>>>> - if (error < 0)
> >>>>> - goto setval_error;
> >>>>> - }
> >>>>> -
> >>>>> /*
> >>>>> - * Now we populate the keyfile format
> >>>>> + * The keyfile format expects the IPv6 and IPv4 configuration in
> >>>>> + * different sections. Therefore we iterate through the list twice,
> >>>>> + * once to populate the IPv4 section and the next time for IPv6
> >>>>> */
> >>>>> + ip_ver = IPV4;
> >>>>> + do {
> >>>>> + if (ip_ver == IPV4) {
> >>>>> + error = fprintf(nmfile, "\n[ipv4]\n");
> >>>>> + if (error < 0)
> >>>>> + goto setval_error;
> >>>>> + } else {
> >>>>> + error = fprintf(nmfile, "\n[ipv6]\n");
> >>>>> + if (error < 0)
> >>>>> + goto setval_error;
> >>>>> + }
> >>>>> 
> >>>>> - if (new_val->dhcp_enabled) {
> >>>>> - error = kvp_write_file(nmfile, "method", "", "auto");
> >>>>> - if (error < 0)
> >>>>> - goto setval_error;
> >>>>> - } else {
> >>>>> - error = kvp_write_file(nmfile, "method", "", "manual");
> >>>>> + /*
> >>>>> + * Now we populate the keyfile format
> >>>>> + */
> >>>>> +
> >>>>> + if (new_val->dhcp_enabled) {
> >>>>> + error = kvp_write_file(nmfile, "method", "", "auto");
> >>>>> + if (error < 0)
> >>>>> + goto setval_error;
> >>>>> + } else {
> >>>>> + error = kvp_write_file(nmfile, "method", "", "manual");
> >>>>> + if (error < 0)
> >>>>> + goto setval_error;
> >>>> 
> >>>> There is a problem with this code. dhcp_enabled is only valid for ipv4. From looking at ifcfg files that were generated before, I do not see IPV6_AUTOCONF related settings.
> >>> 
> >>> So dhcp_enabled comes from running hv_get_shcp_info.sh which greps for ???dhcp??? in ifcfg files. If it is a hit, it sets dhcp_enabled to true.
> >>> The ifcfg files will have ???dhcp??? only if it???s set in BOOTPROTO=dhcp. So it is indeed ipv4 specific.
> >>> 
> >>>> So maybe we should set method only for ipv4 and not for ipv6.
> >> 
> >> After some internal testing, it seems we need to set some method for both,
> >> otherwise, nm is complaining. Therefore, I propose the following patch
> >> 
> >>> From e1c3f4ece2c4bd191369582d84b8b508db5b5510 Mon Sep 17 00:00:00 2001
> >> From: Ani Sinha <anisinha@redhat.com>
> >> Date: Thu, 21 Mar 2024 10:00:26 +0530
> >> Subject: [PATCH] Handle dhcp configuration properly for ipv4 and ipv6
> >> 
> >> dhcp_enabled is only valid for ipv4. So do not set dhcp methods for ipv6 based
> >> on dhcp_enabled flag. For ipv4, set method to manual only when dhcp_enabled is
> >> false and specific ipv4 addresses are configured. If neither dhcp_enabled is
> >> true and no ipv4 addresses are configured, set method to 'disabled'.
> >> 
> >> For ipv6, set method to manual when we configure ipv6 addresses. Otherwise set
> >> method to 'auto' so that SLAAC from RA may be used.
> >> 
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> hv_kvp_daemon.c | 57 +++++++++++++++++++++++++++++++++++--------------
> >> 1 file changed, 41 insertions(+), 16 deletions(-)
> >> 
> >> diff --git a/hv_kvp_daemon.c b/hv_kvp_daemon.c
> >> index b368d3d..a0e6e4a 100644
> >> --- a/hv_kvp_daemon.c
> >> +++ b/hv_kvp_daemon.c
> >> @@ -1286,7 +1286,7 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >> {
> >> char addr[INET6_ADDRSTRLEN];
> >> char subnet_addr[INET6_ADDRSTRLEN];
> >> - int error, i = 0;
> >> + int error = 0, i = 0;
> >> int ip_offset = 0, subnet_offset = 0;
> >> int plen, ip_ver;
> >> 
> >> @@ -1323,7 +1323,7 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >> memset(subnet_addr, 0, sizeof(subnet_addr));
> >> }
> >> 
> >> - return 0;
> >> + return error;
> >> }
> >> 
> >> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> @@ -1511,6 +1511,8 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> goto setval_error;
> >> 
> >> /*
> >> +  * Now we populate the keyfile format
> >> +  *
> >>  * The keyfile format expects the IPv6 and IPv4 configuration in
> >>  * different sections. Therefore we iterate through the list twice,
> >>  * once to populate the IPv4 section and the next time for IPv6
> >> @@ -1527,20 +1529,6 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> goto setval_error;
> >> }
> >> 
> >> - /*
> >> -  * Now we populate the keyfile format
> >> -  */
> >> -
> >> - if (new_val->dhcp_enabled) {
> >> - error = kvp_write_file(nmfile, "method", "", "auto");
> >> - if (error < 0)
> >> - goto setval_error;
> >> - } else {
> >> - error = kvp_write_file(nmfile, "method", "", "manual");
> >> - if (error < 0)
> >> - goto setval_error;
> >> - }
> >> -
> >> /*
> >>  * Write the configuration for ipaddress, netmask, gateway and
> >>  * name services
> >> @@ -1551,6 +1539,43 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >> if (error < 0)
> >> goto setval_error;
> >> 
> >> + if (ip_ver == IPV4) {
> >> + if (new_val->dhcp_enabled) {
> >> + error = kvp_write_file(nmfile, "method", "", "auto");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + } else if (error) {
> >> + /* if ipv4 addresses were written, set method to 'manual' */
> >> + error = kvp_write_file(nmfile, "method", "", "manual");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + } else {
> >> + /*
> >> +  * if no ipv4 addresses were set and dhcp was not enabled,
> >> +  * disable ipv4 configuration.
> >> +  */
> >> + error = kvp_write_file(nmfile, "method", "", "disabled");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + }
> >> +
> >> + } else if (ip_ver == IPV6) {
> >> + if (error) {
> >> + /* if ipv6 addresses were written, set method to 'manual' */
> >> + error = kvp_write_file(nmfile, "method", "", "manual");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + } else {
> >> + /*
> >> +  * By default for ipv6, set method to 'auto' so that
> >> +  * SLAAC in RA can be used to configure the interface
> >> +  */
> >> + error = kvp_write_file(nmfile, "method", "", "auto");
> >> + if (error < 0)
> >> + goto setval_error;
> >> + }
> >> + }
> >> +
> >> error = process_dns_gateway_nm(nmfile,
> >>        (char *)new_val->gate_way,
> >>        GATEWAY, ip_ver);
> >> -- 
> > Hi Ani,
> > Thanks, the proposed patch looks clean and would fix the problem at hand.
> > I was wondering if it would make more sense to implement the distro specific script
> > hv_get_dhcp_info.sh to include dhcp configuration for Ipv6 specific configuration
> > instead.
> 
> The way I see it is that the daemon should provide some ???reasonable??? configuration for both ipv4 and ipv6. Then the distro specific script can override it in any way they see fit if required. Leaving out ipv6 would make it incomplete and half baked.

Sure, That makes sense. Let's go ahead with this then.
> 
> > 
> > I see for IPv6 the older ifcfg format also did not honor dhcp_enable flag, but how about
> > we add support for it starting with the keyfile format in the script.
> > 
> > That way distro vendors could have more control over the logic to get dhcp_enable data
> > and it would be easier to change
> > Thoughts? Hope I am making sense :)
> > 
> > Regards,
> > Shradha.
> 

