Return-Path: <linux-hyperv+bounces-4682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61087A6E990
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E657A289D
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83519E98B;
	Tue, 25 Mar 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dnFzMe5D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88B19007F;
	Tue, 25 Mar 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742883850; cv=none; b=WzFqScvIhZGw3GiqnGQOWGQ17ucXYHXqkfcUaO2kZ6LCnlpLX0ctdwj8I8a4xmGFhXva6ixB+7wdP5zKIeNiUQYGxoGqbGxX1fgqfrGimFxWgfvQ5VrabPSx7Tx6t4xJsyw2IvFk57ZRVyJU7lR0S/oV1efKqgD/urgc4HiVSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742883850; c=relaxed/simple;
	bh=78IUP/E8zp3SBFSGZjfZ0JdsJkR0nMvdIdnx1pzY/Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwvkEYW+/gjgzVM2xMJiRp3oj6ZYeGKrtnmn0cyaCWOA3z3VflIgAveSdqocRVcBf4I9IkXPlyi6gk0buaC0eBRRlS1EQDsd+5rCRzHE8AV3K4lNohd+fJtE0vjNXCvSkSTERDx/chda4J9Gn5g4zaP/CsuuNP0eUKIFs5zM77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dnFzMe5D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 291522036591; Mon, 24 Mar 2025 23:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 291522036591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742883848;
	bh=eIeO+X3sdXDN4SQgv3RFLsF0adLBIrp+lm/jD4fM/7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnFzMe5D5KIs/cRmORSwjqcqaYvolp8oURRxGLQfI5K1Oh4yWreNqcrrl4WzEdwk5
	 ldf56wKphdxEd5gRueLOXqG/ot6SQRv/RUn8bebsh3zpgiV/dfWrolZ6/vUk1QhEGt
	 IcQPe7lCS+RCZRb0t7UsIUhGYxyuS08RjfR5OtJ0=
Date: Mon, 24 Mar 2025 23:24:08 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250325062408.GA22632@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742800492-25911-1-git-send-email-shradhagupta@linux.microsoft.com>
 <Z-GO-VGHMFDIAZ7r@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-GO-VGHMFDIAZ7r@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 24, 2025 at 04:57:29PM +0000, Wei Liu wrote:
> On Mon, Mar 24, 2025 at 12:14:52AM -0700, Shradha Gupta wrote:
> > Allow the KVP daemon to log the KVP updates triggered in the VM
> > with a new debug flag(-d).
> > When the daemon is started with this flag, it logs updates and debug
> > information in /var/log/kvp_debug_file.log. This information comes
> > in handy for debugging issues where the key-value pairs for certain
> > pools show mismatch/incorrect values.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> If debug is enabled, you can just open the file once during
> initialization and close it when the daemon exits.
> 
> If you worry whether the log lines are written, you can use fflush(3) to
> flush the buffer to the file every time you write to it, or use
> setvbuf(3) to disable buffering.
>
sure, that makes sense. I'll make that change 
> > ---
> >  tools/hv/hv_kvp_daemon.c | 120 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 112 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index 04ba035d67e9..1f8b02b17356 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -41,6 +41,7 @@
> >  #include <net/if.h>
> >  #include <limits.h>
> >  #include <getopt.h>
> > +#include <time.h>
> >  
> >  /*
> >   * KVP protocol: The user mode component first registers with the
> > @@ -83,6 +84,7 @@ enum {
> >  };
> >  
> >  static int in_hand_shake;
> > +static int debug_enabled;
> >  
> >  static char *os_name = "";
> >  static char *os_major = "";
> > @@ -91,6 +93,7 @@ static char *processor_arch;
> >  static char *os_build;
> >  static char *os_version;
> >  static char *lic_version = "Unknown version";
> > +static char debug_file[PATH_MAX];
> >  static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
> >  static struct utsname uts_buf;
> >  
> > @@ -99,6 +102,7 @@ static struct utsname uts_buf;
> >   */
> >  
> >  #define KVP_CONFIG_LOC	"/var/lib/hyperv"
> > +#define KVP_DEBUG_LOC	"/var/log/"
> >  
> >  #ifndef KVP_SCRIPTS_PATH
> >  #define KVP_SCRIPTS_PATH "/usr/libexec/hypervkvpd/"
> > @@ -153,6 +157,16 @@ static void kvp_release_lock(int pool)
> >  	}
> >  }
> >  
> > +static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
> > +{
> > +	struct tm tm;
> > +	time_t t;
> > +
> > +	time(&t);
> > +	gmtime_r(&t, &tm);
> > +	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
> > +}
> > +
> >  static void kvp_update_file(int pool)
> >  {
> >  	FILE *filep;
> > @@ -183,6 +197,45 @@ static void kvp_update_file(int pool)
> >  	kvp_release_lock(pool);
> >  }
> >  
> > +static void kvp_dump_initial_pools(int pool)
> > +{
> > +	FILE *debug_filep;
> > +	char tm_str[50];
> > +	int i, ret;
> > +
> > +	convert_tm_to_string(tm_str, sizeof(tm_str));
> > +
> > +	debug_filep = fopen(debug_file, "a");
> > +	if (!debug_filep) {
> > +		syslog(LOG_ERR, "Failed to open file: %s, pool: %d; error: %d%s",
> > +		       debug_file, pool, errno, strerror(errno));
> > +		return;
> > +	}
> > +
> > +	ret = fprintf(debug_filep, "===Start dumping the contents on pool %d ===\n",
> > +		      pool);
> > +	if (ret <= 0) {
> > +		syslog(LOG_ERR, "Failed to write to kvp debug file: %d", pool);
> > +		fclose(debug_filep);
> > +		return;
> > +	}
> > +
> > +	for (i = 0; i < kvp_file_info[pool].num_records; i++) {
> > +		ret = fprintf(debug_filep, "[%s]: pool: %d, %d/%d key=%s val=%s\n",
> > +			      tm_str, pool, i, kvp_file_info[pool].num_records,
> > +			      kvp_file_info[pool].records[i].key,
> > +			      kvp_file_info[pool].records[i].value);
> > +
> > +		if (ret <= 0) {
> > +			syslog(LOG_ERR, "Failed to write to kvp debug file: pool=%d, i=%u/%u",
> > +			       pool, i, kvp_file_info[pool].num_records);
> > +			break;
> > +		}
> > +	}
> > +
> > +	fclose(debug_filep);
> > +}
> > +
> >  static void kvp_update_mem_state(int pool)
> >  {
> >  	FILE *filep;
> > @@ -270,6 +323,8 @@ static int kvp_file_init(void)
> >  			return 1;
> >  		kvp_file_info[i].num_records = 0;
> >  		kvp_update_mem_state(i);
> > +		if (debug_enabled)
> > +			kvp_dump_initial_pools(i);
> >  	}
> >  
> >  	return 0;
> > @@ -321,14 +376,37 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
> >  static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> >  				 const __u8 *value, int value_size)
> >  {
> > -	int i;
> > -	int num_records;
> >  	struct kvp_record *record;
> > +	FILE *filep = NULL;
> > +	int num_records;
> > +	char tm_str[50];
> >  	int num_blocks;
> > +	int i;
> > +
> > +	if (debug_enabled) {
> > +		filep = fopen(debug_file, "a");
> > +		if (!filep) {
> > +			syslog(LOG_ERR, "Failed to open file %s; error: %d",
> > +			       debug_file, errno);
> > +		} else {
> > +			convert_tm_to_string(tm_str, sizeof(tm_str));
> > +			fprintf(filep, "[%s]:%s: got a KVP: pool=%d key=%s val=%s\n",
> > +				__func__, tm_str, pool, key, value);
> > +		}
> > +	}
> >  
> >  	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
> > -		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
> > +		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
> > +		syslog(LOG_ERR, "Got a too long key or value: key=%s, val=%s",
> > +		       key, value);
> > +
> > +		if (filep) {
> > +			fprintf(filep, "[%s]: Got a too long key or value: pool=%d, key=%s, val=%s\n",
> > +				tm_str, pool, key, value);
> > +			fclose(filep);
> > +		}
> >  		return 1;
> > +	}
> >  
> >  	/*
> >  	 * First update the in-memory state.
> > @@ -348,6 +426,11 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> >  		 */
> >  		memcpy(record[i].value, value, value_size);
> >  		kvp_update_file(pool);
> > +		if (filep) {
> > +			fprintf(filep, "[%s]:%s: updated: pool=%d key=%s val=%s\n",
> > +				__func__, tm_str, pool, key, value);
> > +			fclose(filep);
> > +		}
> >  		return 0;
> >  	}
> >  
> > @@ -359,8 +442,12 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> >  		record = realloc(record, sizeof(struct kvp_record) *
> >  			 ENTRIES_PER_BLOCK * (num_blocks + 1));
> >  
> > -		if (record == NULL)
> > +		if (!record) {
> > +			if (filep)
> > +				fclose(filep);
> > +			syslog(LOG_ERR, "%s: Memory alloc failure", __func__);
> >  			return 1;
> > +		}
> >  		kvp_file_info[pool].num_blocks++;
> >  
> >  	}
> > @@ -368,6 +455,12 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> >  	memcpy(record[i].key, key, key_size);
> >  	kvp_file_info[pool].records = record;
> >  	kvp_file_info[pool].num_records++;
> > +
> > +	if (filep) {
> > +		fprintf(filep, "[%s]:%s: added: pool=%d key=%s val=%s\n",
> > +			__func__, tm_str, pool, key, value);
> > +		fclose(filep);
> > +	}
> >  	kvp_update_file(pool);
> >  	return 0;
> >  }
> > @@ -1662,6 +1755,7 @@ void print_usage(char *argv[])
> >  	fprintf(stderr, "Usage: %s [options]\n"
> >  		"Options are:\n"
> >  		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
> > +		"  -d, --debug-enabled    Enable debug logs\n"
> 
> You should specify where the log is written to. The only place that
> tells where it is written to is in syslog.
>
I can add the log location here as well, thanks.
 
> Does systemd has a way to collect logs from a specific daemon? If so,
> we can consider using that facility

yeah, using services that can be done. For hv_kvp_daemon, the services
are defined and configured by distro vendors(ex:
rhel:-hypervkvpd.service, ubuntu:-hv-kvp-daemon.service). Using
StandardOutput, StandardError directives(for these services), these logs
can be configured to be visible in journalctl logs as well.

Thanks,
Shradha
> 
> Thanks,
> Wei.
> 
> >  		"  -h, --help             print this help\n", argv[0]);
> >  }
> >  
> > @@ -1681,12 +1775,13 @@ int main(int argc, char *argv[])
> >  	int daemonize = 1, long_index = 0, opt;
> >  
> >  	static struct option long_options[] = {
> > -		{"help",	no_argument,	   0,  'h' },
> > -		{"no-daemon",	no_argument,	   0,  'n' },
> > -		{0,		0,		   0,  0   }
> > +		{"help",		no_argument,	   0,  'h' },
> > +		{"no-daemon",		no_argument,	   0,  'n' },
> > +		{"debug-enabled",	no_argument,	   0,  'd' },
> > +		{0,			0,		   0,  0   }
> >  	};
> >  
> > -	while ((opt = getopt_long(argc, argv, "hn", long_options,
> > +	while ((opt = getopt_long(argc, argv, "hnd", long_options,
> >  				  &long_index)) != -1) {
> >  		switch (opt) {
> >  		case 'n':
> > @@ -1695,6 +1790,9 @@ int main(int argc, char *argv[])
> >  		case 'h':
> >  			print_usage(argv);
> >  			exit(0);
> > +		case 'd':
> > +			debug_enabled = 1;
> > +			break;
> >  		default:
> >  			print_usage(argv);
> >  			exit(EXIT_FAILURE);
> > @@ -1717,6 +1815,12 @@ int main(int argc, char *argv[])
> >  	 */
> >  	kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
> >  
> > +	if (debug_enabled) {
> > +		sprintf(debug_file, "%s%s", KVP_DEBUG_LOC, "kvp_debug_file.log");
> > +		syslog(LOG_INFO, "Logging debug info in kvp_debug_file=%s",
> > +		       debug_file);
> > +	}
> > +
> >  	if (kvp_file_init()) {
> >  		syslog(LOG_ERR, "Failed to initialize the pools");
> >  		exit(EXIT_FAILURE);
> > -- 
> > 2.34.1
> > 

