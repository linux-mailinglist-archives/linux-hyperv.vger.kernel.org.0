Return-Path: <linux-hyperv+bounces-4876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BBBA8598B
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Apr 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DF9A6FA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Apr 2025 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15C29CB2B;
	Fri, 11 Apr 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ncHgkJ8V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242A29C342;
	Fri, 11 Apr 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366681; cv=none; b=gO7JknhwJO73hhRSiDWqDQf5gFnP5e8UVDk5YmeoFlv+C+8SVzfe1oVHJ+6eozmus9QTyb9WPAqj56y4bR6ZiOx/Ep8x2o3gtJB7YgPa3dEW3DD+lnQVYribAIpaJODgQX2Xf4V5ewtGtfcFs2wssmwVv/ff1AqzzazfjVtTklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366681; c=relaxed/simple;
	bh=U0RjtkfD8KU+TN+Jz93BStnHYL0o+9zR+0KwS1KcHVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfs9GVZ6HC3tHxRM7B/CTAz/kpMIofakLI7LO2vVaSAb21AwzdS8PA1ONWUGaF1VAHalJeDbtTOENbzGm9pqZV7Y1nsyfhRG1DSORpOMaLXoqncwwSooUyY/q4jVVUH0jpaaf/aUMW5mNsEGgkbLOydwaRYPxLH1C0FVMhQlF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ncHgkJ8V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE0712027DE4;
	Fri, 11 Apr 2025 03:17:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE0712027DE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744366673;
	bh=YMuw+VqxevDb1QQRwLEoZdXylBzFyjvS0XVquic1B9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncHgkJ8VHmmn1JXSlZTisKVS/ZDcIbRtpv3RovX5kLBfdegZnfAeYWRb9yMSRmjl9
	 U5DNM1HbTnerlKlgLoIREd/OGjniEmlclhCVQJ/h2EjYdeT2wcKnHreAhxpBw9YFYH
	 avbnrqlMSNB6yhkipNUC7ThhAcpdHqW+PUqKF4RY=
Message-ID: <5495e39e-f5c7-464c-8186-22cbd6c344be@linux.microsoft.com>
Date: Fri, 11 Apr 2025 15:47:49 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@microsoft.com>
References: <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/6/2025 2:18 PM, Shradha Gupta wrote:
> Allow the KVP daemon to log the KVP updates triggered in the VM
> with a new debug flag(-d).
> When the daemon is started with this flag, it logs updates and debug
> information in syslog with loglevel LOG_DEBUG. This information comes
> in handy for debugging issues where the key-value pairs for certain
> pools show mismatch/incorrect values.
> The distro-vendors can further consume these changes and modify the
> respective service files to redirect the logs to specific files as
> needed.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>   Changes in v3:
>   * remove timestamp from raw message
>   * use i+1 instead of i while printing record array
>   * add debug logs in delete operation
> ---
>   Changes in v2:
>   * log the debug logs in syslog(debug) instead of a seperate file that
>     we will have to maintain.
>   * fix the commit message to indicate the same.
> ---
>   tools/hv/hv_kvp_daemon.c | 71 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 04ba035d67e9..7a1b7b0a9233 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -83,6 +83,7 @@ enum {
>   };
>   
>   static int in_hand_shake;
> +static int debug_enabled;
>   
>   static char *os_name = "";
>   static char *os_major = "";
> @@ -183,6 +184,20 @@ static void kvp_update_file(int pool)
>   	kvp_release_lock(pool);
>   }
>   
> +static void kvp_dump_initial_pools(int pool)
> +{
> +	int i;
> +
> +	syslog(LOG_DEBUG, "===Start dumping the contents of pool %d ===\n",
> +	       pool);
> +
> +	for (i = 0; i < kvp_file_info[pool].num_records; i++)
> +		syslog(LOG_DEBUG, "pool: %d, %d/%d key=%s val=%s\n",
> +		       pool, i + 1, kvp_file_info[pool].num_records,
> +		       kvp_file_info[pool].records[i].key,
> +		       kvp_file_info[pool].records[i].value);
> +}
> +
>   static void kvp_update_mem_state(int pool)
>   {
>   	FILE *filep;
> @@ -270,6 +285,8 @@ static int kvp_file_init(void)
>   			return 1;
>   		kvp_file_info[i].num_records = 0;
>   		kvp_update_mem_state(i);
> +		if (debug_enabled)
> +			kvp_dump_initial_pools(i);
>   	}
>   
>   	return 0;
> @@ -297,6 +314,9 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
>   		 * Found a match; just move the remaining
>   		 * entries up.
>   		 */
> +		if (debug_enabled)
> +			syslog(LOG_DEBUG, "%s: deleting the KVP: pool=%d key=%s val=%s",
> +			       __func__, pool, record[i].key, record[i].value);
>   		if (i == (num_records - 1)) {
>   			kvp_file_info[pool].num_records--;
>   			kvp_update_file(pool);
> @@ -315,20 +335,36 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
>   		kvp_update_file(pool);
>   		return 0;
>   	}
> +
> +	if (debug_enabled)
> +		syslog(LOG_DEBUG, "%s: could not delete KVP: pool=%d key=%s. Record not found",
> +		       __func__, pool, key);
> +
>   	return 1;
>   }
>   
>   static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   				 const __u8 *value, int value_size)
>   {
> -	int i;
> -	int num_records;
>   	struct kvp_record *record;
> +	int num_records;
>   	int num_blocks;
> +	int i;
> +
> +	if (debug_enabled)
> +		syslog(LOG_DEBUG, "%s: got a KVP: pool=%d key=%s val=%s",
> +		       __func__, pool, key, value);
>   
>   	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
> -		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
> +		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
> +		syslog(LOG_ERR, "Got a too long key or value: key=%s, val=%s",
> +		       key, value);
> +
> +		if (debug_enabled)
> +			syslog(LOG_DEBUG, "%s: Got a too long key or value: pool=%d, key=%s, val=%s",

There's a checkpatch warning here for 100 chars, but splitting it across 
2 lines again complains. So I think its fine. Otherwise we can change it to:
"%s: Too long key or value: pool=%d, key=%s, val=%s"


> +			       __func__, pool, key, value);
>   		return 1;
> +	}
>   
>   	/*
>   	 * First update the in-memory state.
> @@ -348,6 +384,9 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   		 */
>   		memcpy(record[i].value, value, value_size);
>   		kvp_update_file(pool);
> +		if (debug_enabled)
> +			syslog(LOG_DEBUG, "%s: updated: pool=%d key=%s val=%s",
> +			       __func__, pool, key, value);
>   		return 0;
>   	}
>   
> @@ -359,8 +398,10 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   		record = realloc(record, sizeof(struct kvp_record) *
>   			 ENTRIES_PER_BLOCK * (num_blocks + 1));
>   
> -		if (record == NULL)
> +		if (!record) {
> +			syslog(LOG_ERR, "%s: Memory alloc failure", __func__);
>   			return 1;
> +		}
>   		kvp_file_info[pool].num_blocks++;
>   
>   	}
> @@ -368,6 +409,11 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>   	memcpy(record[i].key, key, key_size);
>   	kvp_file_info[pool].records = record;
>   	kvp_file_info[pool].num_records++;
> +
> +	if (debug_enabled)
> +		syslog(LOG_DEBUG, "%s: added: pool=%d key=%s val=%s",
> +		       __func__, pool, key, value);
> +
>   	kvp_update_file(pool);
>   	return 0;
>   }
> @@ -1662,6 +1708,7 @@ void print_usage(char *argv[])
>   	fprintf(stderr, "Usage: %s [options]\n"
>   		"Options are:\n"
>   		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
> +		"  -d, --debug-enabled    Enable debug logs(syslog debug by default)\n"
>   		"  -h, --help             print this help\n", argv[0]);
>   }
>   
> @@ -1681,12 +1728,13 @@ int main(int argc, char *argv[])
>   	int daemonize = 1, long_index = 0, opt;
>   
>   	static struct option long_options[] = {
> -		{"help",	no_argument,	   0,  'h' },
> -		{"no-daemon",	no_argument,	   0,  'n' },
> -		{0,		0,		   0,  0   }
> +		{"help",		no_argument,	   0,  'h' },
> +		{"no-daemon",		no_argument,	   0,  'n' },
> +		{"debug-enabled",	no_argument,	   0,  'd' },
> +		{0,			0,		   0,  0   }
>   	};
>   
> -	while ((opt = getopt_long(argc, argv, "hn", long_options,
> +	while ((opt = getopt_long(argc, argv, "hnd", long_options,
>   				  &long_index)) != -1) {
>   		switch (opt) {
>   		case 'n':
> @@ -1695,6 +1743,9 @@ int main(int argc, char *argv[])
>   		case 'h':
>   			print_usage(argv);
>   			exit(0);
> +		case 'd':
> +			debug_enabled = 1;
> +			break;
>   		default:
>   			print_usage(argv);
>   			exit(EXIT_FAILURE);
> @@ -1717,6 +1768,9 @@ int main(int argc, char *argv[])
>   	 */
>   	kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
>   
> +	if (debug_enabled)
> +		syslog(LOG_INFO, "Logging debug info in syslog(debug)");
> +
>   	if (kvp_file_init()) {
>   		syslog(LOG_ERR, "Failed to initialize the pools");
>   		exit(EXIT_FAILURE);

LGTM.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

