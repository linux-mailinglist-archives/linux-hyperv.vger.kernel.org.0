Return-Path: <linux-hyperv+bounces-1701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B4B877A25
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 04:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDD6280CFF
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2017D2;
	Mon, 11 Mar 2024 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O7eNa62v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892C15A5;
	Mon, 11 Mar 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128263; cv=none; b=ohEuV0UtFkG6wPORfqyiHe2GceM3QaM8cGqME18j3SFdX4qlncNGxrGCidDUnM7HdBY0LR5nCV17Ffiwi/T6UW70SYUrgTznYwBMImrGxZsEYsMHHRapAvQrB2EF7B7gqBnvg6mi6g4BTpt+plTE29ZxrFiWtf/kb45iM6SAeyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128263; c=relaxed/simple;
	bh=Wp+2CFODpwjtPtjrozncJ1/Odwiekwv08Kdnw072T34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfFbdGK5oRIyWDTUGMfa1HMkHWYfKppUpQESvolmjHufRsgLkC/OZ+v8jwcODWmrYpVHU5kb6Tw2spcypmrh4zupoMjADF34k0yMbWSrS//Mjzo0d2DX4QJttKFJJ7lwTrzoMVIJH/24pm9s8Y4mGwlKazApIFzz16k0xssVqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O7eNa62v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id EF0D320B74C0; Sun, 10 Mar 2024 20:37:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF0D320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710128254;
	bh=UA0/rPCEp3CPu3Py2kKstccVQHFEChGVFCd3s6bNOCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7eNa62v5yOKH3TpBPuKFXXrisL6p2BF4SYAFhQRjUWjXQRr7Qg1Ke9yu907Ttqe5
	 hHoXUPqvqPoomIXmdW6glJiSb1M2C8j7lpTBY8hlrSVIcScoT6ylXqNuXXRfRXl1N8
	 hwrq0wh3zbXCcQU+7k1Wbz2QKrjdR9J9qAELPMHc=
Date: Sun, 10 Mar 2024 20:37:34 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
Message-ID: <20240311033734.GA16436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709297778-20420-1-git-send-email-shradhagupta@linux.microsoft.com>
 <4547D425-64EF-4974-A131-56811F25B9E6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547D425-64EF-4974-A131-56811F25B9E6@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Thanks, will incorporate all these changes in next version

Regards,
Shradha
On Wed, Mar 06, 2024 at 02:57:12PM +0530, Ani Sinha wrote:
> 
> 
> > On 01-Mar-2024, at 18:26, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> > 
> > If the network configuration strings are passed as a combination of IPv and
> > IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
> > configuration format.
> > With these changes, the keyfile config generation logic scans through the
> > list twice to generate IPv4 and IPv6 sections for the configuration files
> > to handle this support.
> > 
> > Built-on: Rhel9
> > Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> > tools/hv/hv_kvp_daemon.c | 152 ++++++++++++++++++++++++++++-----------
> > 1 file changed, 112 insertions(+), 40 deletions(-)
> > 
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index 318e2dad27e0..7e84e40b55fb 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -76,6 +76,11 @@ enum {
> > DNS
> > };
> > 
> > +enum {
> > + IPV4 = 1,
> > + IPV6
> > +};
> > +
> > static int in_hand_shake;
> > 
> > static char *os_name = "";
> > @@ -1171,6 +1176,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
> > return 0;
> > }
> > 
> > +int ip_version_check(const char *input_addr)
> > +{
> > + struct in6_addr addr;
> > +
> > + if (inet_pton(AF_INET, input_addr, &addr))
> > + return IPV4;
> > + else if (inet_pton(AF_INET6, input_addr, &addr))
> > + return IPV6;
> > + else
> > + return -EINVAL;
> > +}
> > +
> > /*
> >  * Only IPv4 subnet strings needs to be converted to plen
> >  * For IPv6 the subnet is already privided in plen format
> > @@ -1197,14 +1214,56 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
> > return plen;
> > }
> > 
> > +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> > +  int ip_sec)
> > +{
> > + char addr[INET6_ADDRSTRLEN], *output_str;
> > + int ip_offset = 0, error, ip_ver;
> > + char *param_name;
> > +
> > + output_str = malloc(strlen(ip_string));
> > +
> > + if (!output_str)
> > + return 1;
> > +
> > + output_str[0] = '\0';
> > +
> > + if (type == DNS)
> > + param_name = "dns";
> > + else
> > + param_name = "gateway";
> > +
> > + while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> > +   (MAX_IP_ADDR_SIZE * 2))) {
> > + ip_ver = ip_version_check(addr);
> > +
> > + if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> > +    (ip_ver == IPV6 && ip_sec == IPV6)) {
> > + strcat(output_str, addr);
> > + strcat(output_str, ",");
> 
> We need to check if we are not going out of bounds here. So existing length of output_str + length of addr + 1 should be < strlen(ip_string) which is the length of the buffer. See parse_ip_val_buffer() how it does out of bounds check.
> 
> > + } else {
> > + continue;
> > + }
> > + }
> > +
> > + if (strlen(output_str)) {
> > + output_str[strlen(output_str) - 1] = '\0';
> > + error = fprintf(f, "%s=%s\n", param_name, output_str);
> > + if (error <  0)
> > + return error;
> > + }
> > +
> > + return 0;
> > +}
> > +
> > static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> > - int is_ipv6)
> > + int ip_sec)
> > {
> > char addr[INET6_ADDRSTRLEN];
> > char subnet_addr[INET6_ADDRSTRLEN];
> > int error, i = 0;
> > int ip_offset = 0, subnet_offset = 0;
> > - int plen;
> > + int plen, ip_ver;
> > 
> > memset(addr, 0, sizeof(addr));
> > memset(subnet_addr, 0, sizeof(subnet_addr));
> > @@ -1216,10 +1275,13 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >       subnet_addr,
> >       (MAX_IP_ADDR_SIZE *
> > 2))) {
> > - if (!is_ipv6)
> > + ip_ver = ip_version_check(addr);
> > + if (ip_ver == IPV4 && ip_sec == IPV4)
> > plen = kvp_subnet_to_plen((char *)subnet_addr);
> > - else
> > + else if (ip_ver == IPV6 && ip_sec == IPV6)
> > plen = atoi(subnet_addr);
> > + else
> > + continue;
> > 
> > if (plen < 0)
> > return plen;
> > @@ -1242,8 +1304,8 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> > char if_filename[PATH_MAX];
> > char nm_filename[PATH_MAX];
> > FILE *ifcfg_file, *nmfile;
> > + int ip_sections_count;
> > char cmd[PATH_MAX];
> > - int is_ipv6 = 0;
> > char *mac_addr;
> > int str_len;
> > 
> > @@ -1421,52 +1483,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> > if (error)
> > goto setval_error;
> > 
> > - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> > - error = fprintf(nmfile, "\n[ipv6]\n");
> > - if (error < 0)
> > - goto setval_error;
> > - is_ipv6 = 1;
> > - } else {
> > - error = fprintf(nmfile, "\n[ipv4]\n");
> > - if (error < 0)
> > - goto setval_error;
> > - }
> > -
> > /*
> > - * Now we populate the keyfile format
> > + * The keyfile format expects the IPv6 and IPv4 configuration in
> > + * different sections. Therefore we iterate through the list twice,
> > + * once to populate the IPv4 section and the next time for IPv6
> > */
> > + ip_sections_count = 1;
> > + do {
> > + if (ip_sections_count == 1) {
> > + error = fprintf(nmfile, "\n[ipv4]\n");
> > + if (error < 0)
> > + goto setval_error;
> > + } else {
> > + error = fprintf(nmfile, "\n[ipv6]\n");
> > + if (error < 0)
> > + goto setval_error;
> > + }
> > 
> > - if (new_val->dhcp_enabled) {
> > - error = kvp_write_file(nmfile, "method", "", "auto");
> > - if (error < 0)
> > - goto setval_error;
> > - } else {
> > - error = kvp_write_file(nmfile, "method", "", "manual");
> > + /*
> > + * Now we populate the keyfile format
> > + */
> > +
> > + if (new_val->dhcp_enabled) {
> > + error = kvp_write_file(nmfile, "method", "", "auto");
> > + if (error < 0)
> > + goto setval_error;
> > + } else {
> > + error = kvp_write_file(nmfile, "method", "", "manual");
> > + if (error < 0)
> > + goto setval_error;
> > + }
> > +
> > + /*
> > + * Write the configuration for ipaddress, netmask, gateway and
> > + * name services
> > + */
> > + error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> > +     (char *)new_val->sub_net,
> > +     ip_sections_count);
> > if (error < 0)
> > goto setval_error;
> > - }
> > 
> > - /*
> > - * Write the configuration for ipaddress, netmask, gateway and
> > - * name services
> > - */
> > - error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> > -     (char *)new_val->sub_net, is_ipv6);
> > - if (error < 0)
> > - goto setval_error;
> > -
> > - /* we do not want ipv4 addresses in ipv6 section and vice versa */
> > - if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
> > - error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> > + error = process_dns_gateway_nm(nmfile,
> > +       (char *)new_val->gate_way,
> > +       GATEWAY, ip_sections_count);
> > if (error < 0)
> > goto setval_error;
> > - }
> > 
> > - if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
> > - error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> > + error = process_dns_gateway_nm(nmfile,
> > +       (char *)new_val->dns_addr, DNS,
> > +       ip_sections_count);
> > if (error < 0)
> > goto setval_error;
> > - }
> > +
> > + ip_sections_count++;
> > + } while (ip_sections_count <= 2);
> > +
> > fclose(nmfile);
> > fclose(ifcfg_file);
> > 
> > -- 
> > 2.34.1
> > 

